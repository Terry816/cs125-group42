//
//  ZotSleepView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/11/24.
//

import SwiftUI
import HealthKit


struct TimePickerView: UIViewRepresentable {
    @Binding var selectedTime: Date

    func makeUIView(context: Context) -> UIDatePicker {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(context.coordinator, action: #selector(Coordinator.timeChanged(_:)), for: .valueChanged)
        return timePicker
    }

    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.date = selectedTime
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: TimePickerView

        init(_ parent: TimePickerView) {
            self.parent = parent
        }

        @objc func timeChanged(_ timePicker: UIDatePicker) {
            parent.selectedTime = timePicker.date
        }
    }
}


func formattedTime(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
}


func formattedSecondTime(from timeInterval: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.unitsStyle = .abbreviated

    return formatter.string(from: timeInterval) ?? ""
}


func formattedThirdTime(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter.string(from: date)
}


func extractBedtime(from sleepEntry: String) -> String {
    guard let startIndex = sleepEntry.range(of: "start: ")?.upperBound,
          let endIndex = sleepEntry.range(of: ", end:")?.lowerBound else {
        return "Unknown"
    }

    let bedtime = String(sleepEntry[startIndex..<endIndex])
    return bedtime
}

func extractWakeUpTime(from sleepEntry: String) -> String {
    guard let startIndex = sleepEntry.range(of: "end: ")?.upperBound else {
        return "Unknown"
    }

    let wakeUpTime = String(sleepEntry[startIndex...])
    return wakeUpTime
}

func formattedCurrentDay() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter.string(from: Date())
   }

func formattedCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy"
    return formatter.string(from: Date())
   }


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

//                    var sleepEntries: [String] = []
//                    var totalDuration: TimeInterval = 0
                    var inBedStart: Date?
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
//                        let sleepEntry = "Sleep start: \(formattedThirdTime(from: startDate)), end: \(formattedThirdTime(from: endDate))"
//                        print(sleepEntry)
//                        sleepEntries.append(sleepEntry)

                        // Calculate the duration of each sleep session
//                        let duration = endDate.timeIntervalSince(startDate)
//                        totalDuration += duration
                        
                        if value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                            if inBedStart == nil {
                                inBedStart = startDate
                            }
                        }
                        else {
                            if let start = inBedStart {
//                                inBedDuration = 3600
                                inBedDuration += endDate.timeIntervalSince(start)
                                inBedStart = nil
                            }
                        }
                        
                        // Check for deep sleep (hypothetical example)
//                        if value == HKCategoryValueSleepAnalysis.deepSleep.rawValue {
//                            print("This portion is deep sleep.")
//                        }
                    }

                    // Update the sleepData array and totalSleepDuration
//                    sleepData = ["Sleep start: 10:30pm, end: 6:00am"]
                    
                    
                    // Filter startList to only include dates equal to or after the current date
//                    let filteredStartList = startList.filter { $0 >= current ?? Date() }

                    // Filter endList to only include dates equal to or before the current date
//                    let filteredEndList = endList.filter { $0 <= current ?? Date() }

                    if let firstStartDate = startList.last, let firstEndDate = endList.first {
                        // Calculate the time interval in seconds
                        bedTime = firstStartDate
                        wakeTime = firstEndDate
                        
                        let timeIntervalInSeconds = firstEndDate.timeIntervalSince(firstStartDate)
                        totalSleepDuration = timeIntervalInSeconds
                        inBedDuration = timeIntervalInSeconds + 1800
                        
                    } else {
                        print("Either start list or end list is empty.")
                    }
                    
                    let sleepQualityPercentage = calculateSleepQualityPercentage()
                    let numericValue: CGFloat = CGFloat(sleepQualityPercentage) // Replace with your actual numeric value
                    progress = numericValue / 100.0
                    
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
        
        NavigationView {
            
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
                                    
                                    Text("ZotSleep")
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
                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    


                    //--------------------------------------------------------
                    // ACTUAL SLEEP DATA
                    VStack {

                        //--------------------------------------------------------
                        // Date
                        VStack(alignment: .leading) {
                            // Display the current day
                            Text("Today, \(formattedCurrentDay())")
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
                                Text("Quality")
                                    .padding()
                                    .padding(.top, -7)
                                    .font(.system(size: 18, weight: .bold, design: .rounded))

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
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
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
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .padding(.bottom, 15)
                            
                            HStack{
                                Image(systemName: "moon.fill")
                                    .font(.system(size: 20))
                                    

                                VStack{
                                    Text("---")
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
                                    Text("---")
                                        .font(.system(size: 18))

                                    Text("Fell asleep")
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
                        NavigationLink(destination: SleepResultView()) {
                            Text("Calculate Sleep Time")
                                .padding()
                                .background(Color(hue: 1.0, saturation: 0.591, brightness: 0.87))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.bottom)
//                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    
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



struct CircularProgressView: View {
  let progress: CGFloat

  var body: some View {
    ZStack {
      // Background for the progress bar
      Circle()
        .stroke(lineWidth: 20)
        .opacity(0.1)
        .foregroundColor(.black)

      // Foreground or the actual progress bar
      Circle()
        .trim(from: 0.0, to: min(progress, 1.0))
        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
        .foregroundColor(.black)
        .rotationEffect(Angle(degrees: 270.0))
        .animation(.linear, value: progress)
        
        Text("\(Int(progress * 100))%")
            .foregroundColor(.black)
            .font(.custom("Oswald", fixedSize: 20))
    }
  }
}

#Preview {
    ZotSleepView()
}
