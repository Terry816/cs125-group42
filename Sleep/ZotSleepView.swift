//
//  ZotSleepView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/11/24.
//

import SwiftUI
import HealthKit


struct ZotSleepView: View {
    @State private var sideMenu = false
    @State private var selectedTime = Date()
    @State private var selectedHours = 0
//    @State private var displayTime = Date()
    @State private var showAlert = false
    
    @State private var showSleepResult = false
    
    @State private var isAuthorized = false
    var healthStore: HKHealthStore = HKHealthStore()
    
    
    
//    "Sleep start: 2022-02-20 22:30:00 +0000, end: 2022-02-21 07:00:00 +0000",
//     "Sleep start: 2022-02-19 23:00:00 +0000, end: 2022-02-20 06:45:00 +0000",
//     "Sleep start: 2022-02-18 22:15:00 +0000, end: 2022-02-19 06:30:00 +0000"
    
    
    @State private var sleepData: [String] = [] // Store sleep data here
    @State private var totalSleepDuration: TimeInterval = 0
    @State private var inBedDuration: TimeInterval = 27000          // change minutes for in-bed
    @State private var deepSleepDuration: TimeInterval = 8928       // deep duration is hardcoded for now. need to access AppleWatch for deep data
    
    
    @State private var bedTime: Date = Date()
    @State private var wakeTime: Date = Date()
    
    @State private var deepSleep: TimeInterval = 0
    @State private var remSleep: TimeInterval = 0
    @State private var inBedSleep: TimeInterval = 0
    @State private var aSleep: TimeInterval = 0
    
    @State private var progress: CGFloat = 0.2

    private func calculateSleepQualityPercentage() -> Int {
            // Adjust these weights based on your criteria
            let durationWeight = 0.6
            let efficiencyWeight = 0.2
            let deepSleepWeight = 0.2
            
            print("S:", totalSleepDuration, "E:", inBedDuration)
        
            // Assuming these are normalized values between 0 and 1
            let normalizedDuration = min(totalSleepDuration / inBedDuration, 1)
            let normalizedEfficiency = 1.0 // You can calculate this based on wakefulness periods during sleep
            let normalizedDeepSleep = min(deepSleepDuration / totalSleepDuration, 1)

            // Calculate the weighted average
            let weightedAverage = (normalizedDuration * durationWeight) + (normalizedEfficiency * efficiencyWeight) + (normalizedDeepSleep * deepSleepWeight)

            // Convert to percentage
            let sleepQualityPercentage = Int(weightedAverage * 100)

            return sleepQualityPercentage
        }
    
    private func requestAuthorization() {
        
        let healthStore = HKHealthStore()
        
        // Request authorization to access sleep data
        let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { (success, error) in
            
            if success {
                
//                let endDate = Date()
//                let startDate = endDate.addingTimeInterval(-1.0 * 60.0 * 60.0 * 96.0)
//                let endDate2 = startDate.addingTimeInterval(-1.0 * 60.0 * 60.0 * 24.0)
//                let predicate = HKQuery.predicateForSamples(withStart: endDate2, end: startDate, options: [])
                let endDate = Date()
                let startDate = endDate.addingTimeInterval(-1.0 * 60.0 * 60.0 * 24.0)
                let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])
                
                // Query for sleep data
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                    guard let samples = samples as? [HKCategorySample], error == nil else {
                        print("Failed to fetch sleep data: \(error!.localizedDescription)")
                        return
                    }


                    var current: Date? = nil
                    
                    var startList: [Date] = []
                    var endList: [Date] = []
                    
                    for sample in samples {
                        
                        let startDate = sample.startDate
                        let endDate = sample.endDate
                        let value = sample.value
                        
                        if current == nil{
                            current = startDate
                        }
                        
                        startList.append(startDate)
                        endList.append(endDate)
                        
                        print("Start:",startDate)
                        print("End:",endDate)
                        
                        if value == HKCategoryValueSleepAnalysis.asleepDeep.rawValue {
                            print("This is deepSleep")
                            deepSleep += endDate.timeIntervalSince(startDate)
                        }
                        
                        if value == HKCategoryValueSleepAnalysis.asleepREM.rawValue {
                            print("This is REMSleep")
                            remSleep += endDate.timeIntervalSince(startDate)
                        }
                        
                        if value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                            print("This is inBed")
                            print("\(formattedThirdTime(from: startDate))")
                            print("\(formattedThirdTime(from: endDate))")
                            inBedSleep += endDate.timeIntervalSince(startDate)
                            print("LL:", inBedSleep)
                        }
                        
                        if value == HKCategoryValueSleepAnalysis.asleepUnspecified.rawValue {
                            print("This is asleep")
                            print("\(formattedThirdTime(from: startDate))")
                            print("\(formattedThirdTime(from: endDate))")
                            aSleep += endDate.timeIntervalSince(startDate)
                        }
                        
//                        print("VALUE", value)
                        
                    }

                    
                    // startList.last - WOKE UP
                    // endList.first - WENT TO BED
                    if let firstStartDate = startList.last, let firstEndDate = endList.first {
                        
                        // Calculate the time interval in seconds
                        bedTime = firstStartDate
                        wakeTime = firstEndDate
                        
                        let timeIntervalInSeconds = firstEndDate.timeIntervalSince(firstStartDate)
                        totalSleepDuration = timeIntervalInSeconds
                        
                        if inBedDuration == 27000{
                            inBedDuration = timeIntervalInSeconds + 840
                        }
                        else{
                            inBedDuration = inBedSleep
                        }
                        
                        deepSleepDuration = deepSleep
                        
                        
                    }
                    else {
                        print("Either start list or end list is empty.")
                    }
                    
                    
                    
                    let sleepQualityPercentage = calculateSleepQualityPercentage()
                    let numericValue: CGFloat = CGFloat(sleepQualityPercentage) // Replace with your actual numeric value
                    progress = numericValue / 100.0
                    
//                    inBedDuration = inBedSleep - totalSleepDuration
                    
                    
                    
//                    print("Progress:", progress)
//                    sleepData = sleepEntries
//                    totalSleepDuration = 25200
                }
                
                healthStore.execute(query)
            }
            
            else {
                print("Authorization to access sleep data was denied.")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                if sideMenu {
                    SideMenuView()
                }
                
                //--------------------------------------------------------
                // HealthKit Authorization
                VStack {
                    if isAuthorized == false {
                        Text("Please authorize HealthKit")
                            .padding()
                            .onAppear {
                                requestAuthorization()
                                isAuthorized = true
                            }
                    }
                }
                //--------------------------------------------------------
                VStack {
                    // Top bar ZOTSLEEP
                    HStack(alignment: .center){
                        ZStack{
                            
                            //--------------------------------------------------------
                            HStack{
                                Button(action: {
                                    withAnimation(.spring()) {
                                        sideMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                        .foregroundColor(.white)
                                }.padding([.leading])
                                Spacer()
                            }
                            
                            //--------------------------------------------------------
                            HStack{
                                Spacer()
                                VStack {
                                    
                                    Text("Sleep")
                                        .foregroundColor(.white)
                                        .font(.system(size: 30, weight: .bold))
                                    Spacer()
                                    
                                }
                                .frame(height: 50)
                                Spacer()
                            }
                            //--------------------------------------------------------
                        }
                    }
                    .background(Color(red: 0.14, green: 0.14, blue: 0.14))
                    


                    //--------------------------------------------------------
                    // ACTUAL SLEEP DATA
                    VStack {

                        //--------------------------------------------------------
                        // Date
                        VStack(alignment: .leading) {
                            // Display the current day
                            Text("\(formattedCurrentDay()),")
                                .font(.system(size: 30, weight: .heavy, design: .rounded))
//                                .bold()
//                                .font(.system(size: 30)) // Adjust size
//                                .font(.custom("Playfair", fixedSize: 30))
                                .padding(.bottom, 1)
                            Text(formattedCurrentDate())
                                .font(.system(size: 18, design: .rounded))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        //--------------------------------------------------------
                        
                        // 1) Total Sleep Duration
                        // 2) Total In-Bed Duration
                        // 3) Bedtime
                        // 4) Wake-up Time
                        HStack{
                            //--------------------------------------------------------
                            // Circle Progress Bar for SLEEP QUALITY
                            VStack {
                                Text("Sleep Score")
                                    .padding()
                                    .padding(.top, -7)
                                    .font(.system(size: 16, weight: .bold, design: .rounded))

//                                    .frame(width: 110, height: 40)
                                CircularProgressView(progress: progress)
                                    .frame(width: 115, height: 105)
                                    .padding(.top, 13)
                            }
//                            .onAppear {
//                                // Here you can update the progress based on your numeric value
//                                // For example, if your numeric value ranges from 0 to 100, you can normalize it to a value between 0 and 1
//                                let sleepQualityPercentage = calculateSleepQualityPercentage()
//                                let numericValue: CGFloat = CGFloat(sleepQualityPercentage) // Replace with your actual numeric value
//                                self.progress = numericValue / 100.0
//                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(20)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.horizontal,10)
                            .padding(.bottom, 8)
                            
                            //--------------------------------------------------------
                            // Right box
                            VStack(alignment: .leading) {
                                Text("Duration")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(.bottom, 4)
//                                    .frame(width: 100, height: 50)
                                    
//                                Spacer()

                                Text("\(formattedSecondTime(from: totalSleepDuration))")
                                    .font(.system(size: 26)) // Adjust the size as needed
                                
                                Text("Total Sleep")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary) // Lighter text color
                                    .padding(.bottom, 4)
                                
//                                Spacer()
                                
                                Text("\(formattedSecondTime(from: inBedDuration))")
                                    .font(.system(size: 26)) // Adjust the size as needed

                                Text("In-Bed")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary) // Lighter text color
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(30)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.horizontal,10)
                            .padding(.bottom, 8)
//                            .frame(width: 170, height: 100)
                            //--------------------------------------------------------
                        }
                        
                        Spacer()
                        Spacer()
                        
                            
//                        List(sleepData, id: \.self) { sleepEntry in
//                            Text(sleepEntry)
//                        }
//                        .padding()
                        
                        //--------------------------------------------------------
                        VStack(alignment: .leading) {
                            
                            Text("Sleep Information")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .padding(.bottom, 15)
                            
                            HStack{
                                Image(systemName: "moon.fill")
                                    .font(.system(size: 20))
                                    

                                VStack{
                                    Text(deepSleep == 0 ? "---" : "\(formattedSecondTime(from: deepSleep))")
                                        .font(.system(size: 18)) // Adjust the size as needed

                                    Text("Deep Sleep")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary) // Lighter text color
                                }
                                .padding(.horizontal, 8)
                                
                                Image(systemName: "zzz")
                                    .font(.system(size: 26))
                                    .padding(.horizontal,10)
                                
                                VStack{
                                    Text(deepSleep == 0 ? "---" : "\(formattedSecondTime(from: remSleep))")
                                        .font(.system(size: 18))

                                    Text("REM sleep")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 15)
//                            .padding(.horizontal, 10)

                            // Display bedtime based on the start time of the first sleep entry
                            
//                            let bedtime = extractBedtime(from: firstSleepEntry)
//                            let wakeUpTime = extractWakeUpTime(from: firstSleepEntry)

                            HStack{
                                Image(systemName: "bed.double.fill")
                                    .font(.system(size: 20))
                                    

                                VStack{
                                    Text("\(formattedThirdTime(from: bedTime))")
                                        .font(.system(size: 18)) // Adjust the size as needed

                                    Text("Went to bed")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary) // Lighter text color
                                }
                                
                                Image(systemName: "sun.max.fill")
                                    .font(.system(size: 26))
                                    .padding(.horizontal,10)
                                
                                VStack{
                                    Text("\(formattedThirdTime(from: wakeTime))")
                                        .font(.system(size: 18))

                                    Text("Woke up")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            

                        }
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(20)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal,10)
                        .padding(.top,10)
                        .padding(.bottom, 8)
//                        //--------------------------------------------------------

                        Spacer()
                        
                    }

                    //--------------------------------------------------------
                    // SLEEP HOURS (Navigation)
                    
                    VStack{
//                        Spacer()
                        NavigationLink(destination: SleepResultView().navigationBarBackButtonHidden()) {
                            Text("Calculate Sleep Time")
                                .padding()
                                .background(Color(red: 0.14, green: 0.14, blue: 0.14))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        }
                        
                        Spacer()
                    }
                    .padding(.top)
//                    .padding(.bottom)
//                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    
                    VStack{
//                        Spacer()
                        NavigationLink(destination: SleepImproveView(progress: $progress).navigationBarBackButtonHidden()) {
                            Text("Improve Sleep Score ")
                                .padding()
                                .background(Color(red: 0.14, green: 0.14, blue: 0.14))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                        }
                        
                        Spacer()
                    }
//                    .padding(.top)
                    .padding(.bottom)
                    
                    //--------------------------------------------------------
                }
                .background(Color.white)
                .offset(x: sideMenu ? 250 : 0)
                //--------------------------------------------------------
                .onTapGesture {
                    if sideMenu {
                        withAnimation {
                            sideMenu = false
                        }
                    }
                }
                //--------------------------------------------------------
            }
            .onAppear {
                sideMenu = false
            }
        }
    }
}


#Preview {
    ZotSleepView()
}
