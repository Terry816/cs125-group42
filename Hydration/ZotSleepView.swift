//
//  ZotSleepView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/11/24.
//

import SwiftUI
import HealthKit

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

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

struct ZotSleepView: View {
    @State private var sideMenu = false
    @State private var selectedTime = Date()
    @State private var selectedHours = 0
    @State private var displayTime = Date()
    @State private var showAlert = false
    
    @State private var showSleepResult = false
    
    @State private var isAuthorized = false
    var healthStore: HKHealthStore = HKHealthStore()
    
//    private func formattedTime(from date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        return formatter.string(from: date)
//    }
    
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
                    for sample in samples {
                        let startDate = sample.startDate
                        let endDate = sample.endDate
                        print("Sleep start: \(startDate), end: \(endDate)")
                    }
                }
                healthStore.execute(query)
            } else {
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
                        Spacer()
                        Text("When do you want to wake up?")
                            .font(.system(size: 20, weight: .bold))

                        //Main content goes here
                        DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(.wheel)
                                        .labelsHidden()
                                        .onChange(of: selectedTime) { oldvalue, newValue in
                                            displayTime = newValue
                                        }

//                        Text("What's the minimum amount of sleep you need?")
//                            .font(.system(size: 20, weight: .bold))
//                        
//                        HStack {
//                            
//                            Button("-") {
//                                if selectedHours > 0 {
//                                    selectedHours -= 1
//                                }
//                            }
//                            .buttonStyle(.bordered)
//                            Text("\(selectedHours) hours")
//                            Button("+") {
//                                selectedHours += 1
//                            }
//                            .buttonStyle(.bordered)
//                            
//                        }
                        
//                        Spacer()
//                        
//                        HStack{
//                            Text("Last Selected Time: \(formattedTime(from: displayTime))")
//                        }
                        
                        Spacer()
                    }
                    
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
                }
                .background(.white)
                .offset(x: sideMenu ? 250 : 0)
                .onTapGesture {
                    if sideMenu {
                        withAnimation {
                            sideMenu = false
                        }
                    }
                }
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

#Preview {
    ZotSleepView()
}
