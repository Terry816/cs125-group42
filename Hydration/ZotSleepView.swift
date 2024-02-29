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


struct ZotSleepView: View {
    @State private var sideMenu = false
    @State private var selectedTime = Date()
    @State private var selectedHours = 0
    @State private var displayTime = Date()
    @State private var showAlert = false
    
    @State private var showSleepResult = false
    
    @State private var isAuthorized = false
    var healthStore: HKHealthStore = HKHealthStore()
    
    
//    "Sleep start: 2022-02-20 22:30:00 +0000, end: 2022-02-21 07:00:00 +0000",
//     "Sleep start: 2022-02-19 23:00:00 +0000, end: 2022-02-20 06:45:00 +0000",
//     "Sleep start: 2022-02-18 22:15:00 +0000, end: 2022-02-19 06:30:00 +0000"
    
    
    @State private var sleepData: [String] = [] // Store sleep data here
    @State private var totalSleepDuration: TimeInterval = 3600
    @State private var inBedDuration: TimeInterval = 0
    @State private var deepSleepDuration: TimeInterval = 900
    
    @State private var progress: CGFloat = 0.2

    private func calculateSleepQualityPercentage() -> Int {
            // Adjust these weights based on your criteria
            let durationWeight = 0.6
            let efficiencyWeight = 0.2
            let deepSleepWeight = 0.2

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
                
                // Query for sleep data
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 30, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                    guard let samples = samples as? [HKCategorySample], error == nil else {
                        print("Failed to fetch sleep data: \(error!.localizedDescription)")
                        return
                    }

                    var sleepEntries: [String] = []
                    var totalDuration: TimeInterval = 0
                    var inBedStart: Date?

                    for sample in samples {
                        
                        let startDate = sample.startDate
                        let endDate = sample.endDate
                        let value = sample.value
                        
                        let sleepEntry = "Sleep start: \(formattedThirdTime(from: startDate)), end: \(formattedThirdTime(from: endDate))"
                        print(sleepEntry)
                        sleepEntries.append(sleepEntry)

                        // Calculate the duration of each sleep session
                        let duration = endDate.timeIntervalSince(startDate)
                        totalDuration += duration
                        
                        if value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                            if inBedStart == nil {
                                inBedStart = startDate
                            }
                        } 
                        else {
                            if let start = inBedStart {
//                                inBedDuration = 360
                                inBedDuration += endDate.timeIntervalSince(start)
                                inBedStart = nil
                            }
                        }
                    }

                    // Update the sleepData array and totalSleepDuration
                    sleepData = ["Sleep start: 2:30pm, end: 7:00pm"]
//                    sleepData = sleepEntries
                    totalSleepDuration = 4000
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
                    if isAuthorized {
                        Text("HealthKit Authorization Successful")
                            .padding()
                    } else {
                        Text("Please authorize HealthKit")
                            .padding()
                            .onAppear {
                                requestAuthorization()
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
                    
//                    VStack {
//                        Spacer()
//                        Text("When do you want to wake up?")
//                            .font(.system(size: 20, weight: .bold))
//
//                        //Main content goes here
//                        DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
//                                        .datePickerStyle(.wheel)
//                                        .labelsHidden()
//                                        .onChange(of: selectedTime) { oldvalue, newValue in
//                                            displayTime = newValue
//                                        }
//
////                        Text("What's the minimum amount of sleep you need?")
////                            .font(.system(size: 20, weight: .bold))
////                        
////                        HStack {
////                            
////                            Button("-") {
////                                if selectedHours > 0 {
////                                    selectedHours -= 1
////                                }
////                            }
////                            .buttonStyle(.bordered)
////                            Text("\(selectedHours) hours")
////                            Button("+") {
////                                selectedHours += 1
////                            }
////                            .buttonStyle(.bordered)
////                            
////                        }
//                        
////                        Spacer()
////                        
////                        HStack{
////                            Text("Last Selected Time: \(formattedTime(from: displayTime))")
////                        }
//                        
//                        Spacer()
//                    }
                    
                    //--------------------------------------------------------
                    // ACTUAL SLEEP DATA
                    VStack {
                        
                        // 1) Total Sleep Duration
                        // 2) Total In-Bed Duration
                        // 3) Bedtime
                        // 4) Wake-up Time
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Sleep Info")
                                    .font(.headline)
                                    .bold()
                                
//                                Spacer()
                                
                                // Display bedtime based on the start time of the first sleep entry
                                if let firstSleepEntry = sleepData.first {
                                    let bedtime = extractBedtime(from: firstSleepEntry)
                                    
                                    Text("\(bedtime)")
                                        .font(.system(size: 30)) // Adjust the size as needed
                                    
                                    Text("Went to bed")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary) // Lighter text color
                                    
//                                    Spacer()
                                    
                                    // Display wake-up time based on the end time of the first sleep entry
                                    let wakeUpTime = extractWakeUpTime(from: firstSleepEntry)
                                    
                                    Text("\(wakeUpTime)")
                                        .font(.system(size: 30)) // Adjust the size as needed
                                    
                                    Text("Woke up")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary) // Lighter text color
                                }
                                
                                
                                
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(30)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                            
                            
                            VStack(alignment: .leading) {
                                Text("Duration")
                                    .font(.headline)
                                    .bold()
                                
//                                Spacer()

                                Text("\(formattedSecondTime(from: totalSleepDuration))")
                                    .font(.system(size: 30)) // Adjust the size as needed

                                Text("Total Sleep")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary) // Lighter text color
                                
//                                Spacer()
                                
                                Text("\(formattedSecondTime(from: inBedDuration))")
                                    .font(.system(size: 30)) // Adjust the size as needed

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
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                        }
                        
                        Spacer()
                        
                            
//                        List(sleepData, id: \.self) { sleepEntry in
//                            Text(sleepEntry)
//                        }
//                        .padding()
                        
                        VStack {
                            Text("Quality")
                            CircularProgressView(progress: progress)
                                .frame(width: 200, height: 200) // adjust size as needed
                        }
                        .onAppear {
                            // Here you can update the progress based on your numeric value
                            // For example, if your numeric value ranges from 0 to 100, you can normalize it to a value between 0 and 1
                            let sleepQualityPercentage = calculateSleepQualityPercentage()
                            let numericValue: CGFloat = CGFloat(sleepQualityPercentage) // Replace with your actual numeric value
                            self.progress = numericValue / 100.0
                        }

                        
                        Spacer()
                        
                    }
                    //--------------------------------------------------------
                    // SLEEP HOURS (Navigation)
                    HStack{
                        Spacer()
                        NavigationLink(destination: SleepResultView(displayTime: formattedTime(from: displayTime))) {
                                                    Text("Test")
                                                }
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    
                    //--------------------------------------------------------
                }
                .background(.white)
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





func calculateBedtimeOptions(displayTime: String, totalSleepDuration: TimeInterval) -> [Date] {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mma"
    
    // Convert displayTime string to Date
    guard let wakeUpTime = formatter.date(from: displayTime) else {
        return []  // Return an empty array if the conversion fails
    }

    // Rest of the function remains the same
    let sleepCycleDuration: TimeInterval = 90 * 60
    let optimalBedtime = wakeUpTime.addingTimeInterval(-totalSleepDuration)
    let numberOfCycles = Int(totalSleepDuration / sleepCycleDuration)
    
    var bedtimeOptions: [Date] = []
    for i in 0...numberOfCycles {
        let bedtime = optimalBedtime.addingTimeInterval(-TimeInterval(i) * sleepCycleDuration)
        bedtimeOptions.append(bedtime)
    }
    
    return bedtimeOptions
}

struct SleepResultView: View {
    var displayTime: String
    @State private var sideMenu = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                VStack {
                    HStack(alignment: .center){
                        ZStack{
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
                        }
                    }
                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    
                    VStack {
                        
                        VStack {
                            
                            HStack{
                                Text("Bedtime Options")
                                    .font(.system(size: 24, weight: .bold))  // Adjust the size as needed
                            }
                            
                            Spacer()
                            
                            HStack{
                                Text("To wake up refreshed at \(displayTime), you can consider going to sleep at one of the following times:")
                                    .multilineTextAlignment(.center)
                            }
                            
                            Spacer()
                            
                            VStack{
                                ForEach(calculateBedtimeOptions(displayTime: displayTime, totalSleepDuration: 7 * 3600).sorted(), id: \.self) { bedtime in
                                        Text("\(formattedTime(from: bedtime))")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding()
                                            .background(Color(.systemGray6))
                                            .cornerRadius(10)
                                            .shadow(radius: 2)
                                            .padding(.horizontal)
                                            .padding(.bottom, 8)
                                    }
                            }
                            Spacer()
                        }
                        HStack{
                            Spacer()
                        }
                        .padding(.top)
                        .padding(.bottom)
                        .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    }
                }
                .offset(x: sideMenu ? 300 : 0)
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
            .font(.headline)
            .foregroundColor(.black)
    }
  }
}

#Preview {
    ZotSleepView()
}
