import SwiftUI

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

struct ZotSleepView: View {
    @State private var sideMenu = false
    @State private var selectedTime = Date()
    @State private var selectedHours = 0
    @State private var displayTime = Date()
    @State private var showAlert = false
    
    private func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
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
                            Text("\(selectedHours) hours")
                            Button("+") {
                                selectedHours += 1
                            }
                            
                        }
                        
                        Spacer()
                        
                        HStack{
                            Text("Last Selected Time: \(formattedTime(from: displayTime))")
                        }
                        
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        Button("Test"){
                            showAlert = true
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("SLEEP BY"), message: Text("Selected Time: \(formattedTime(from: displayTime))"), dismissButton: .default(Text("OK")))
                        }
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                }
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

#Preview {
    ZotSleepView()
}
