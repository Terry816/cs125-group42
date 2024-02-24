//
//  ZotSleepView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/11/24.
//

import SwiftUI


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
    
//    private func formattedTime(from date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        return formatter.string(from: date)
//    }
    
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
                        
                        Text("When do you want to wake up?")
                            .font(.system(size: 20, weight: .bold))

                        //Main content goes here
                        DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(.wheel)
                                        .labelsHidden()
                                        .onChange(of: selectedTime) { oldvalue, newValue in
                                            displayTime = newValue
                                        }

                        Text("What's the minimum amount of sleep you need?")
                            .font(.system(size: 20, weight: .bold))
                        
                        HStack {
                            
                            Button("-") {
                                if selectedHours > 0 {
                                    selectedHours -= 1
                                }
                            }
                            .buttonStyle(.bordered)
                            Text("\(selectedHours) hours")
                            Button("+") {
                                selectedHours += 1
                            }
                            .buttonStyle(.bordered)
                            
                        }
                        
                        Spacer()
                        
                        HStack{
                            Text("Last Selected Time: \(formattedTime(from: displayTime))")
                        }
                        
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

func calculateBedtimeOptions(wakeUpTime: Date, totalSleepDuration: TimeInterval) -> [Date] {
    // Define the average sleep cycle duration in seconds (90 minutes)
    let sleepCycleDuration: TimeInterval = 90 * 60
    
    // Calculate the optimal bedtime
    let optimalBedtime = wakeUpTime.addingTimeInterval(-totalSleepDuration)
    
    // Calculate the number of sleep cycles needed
    let numberOfCycles = Int(totalSleepDuration / sleepCycleDuration)
    
    // Generate an array of suggested bedtimes
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
                                ForEach(calculateBedtimeOptions(wakeUpTime: Date(), totalSleepDuration: 7 * 3600), id: \.self) { bedtime in
                                        Text("\(formattedTime(from: bedtime))")
                                            .font(.headline) // Adjust the font style and size
                                            .foregroundColor(.black) // Choose an appropriate text color
                                            .padding()
                                            .background(Color(.systemGray6)) // Choose a neutral background color
                                            .cornerRadius(10)
                                            .shadow(radius: 2)
                                            .padding(.horizontal) // Adjust horizontal padding
                                            .padding(.bottom, 8) // Add bottom spacing
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
