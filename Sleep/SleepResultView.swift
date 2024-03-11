//
//  SleepResultView.swift
//  Hydration
//
//  Created by Philip Nguyen on 2/24/24.
//

import Foundation
import SwiftUI
import HealthKit



struct SleepResultView: View {
//    var displayTime: String
    @State private var sideMenu = false
    @State private var selectedTime = Date()
    @State private var displayTime = Date()
    
    var body: some View {
        
//        NavigationView {
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
                        
                        Spacer()
                        
                        VStack {
                            Spacer()
                            Text("When do you want to wake up?")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            
                            //Main content goes here
                            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                                .onChange(of: selectedTime) { oldvalue, newValue in
                                    displayTime = newValue
                                }
 
                            Spacer()
                        }
                        
                        
                        VStack{
                            NavigationLink(destination: SleepCalcView(displayTime: $displayTime)) {
                                Text("Confirm Time: \(formattedTime(from:displayTime))")
                                    .padding()
//                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                                    .cornerRadius(10)
                            }
                            Spacer()
                        }
                        .padding(.top, 30)
                        
                        
//                        HStack{
//                            Spacer()
//                        }
//                        .padding(.top)
//                        .padding(.bottom)
//                        .background(Color(red: 0, green: 0.3922, blue: 0.6431))
                    }
                    .padding(.top, 100)
                }
                .offset(x: sideMenu ? 300 : 0)
            }
            .onAppear {
                sideMenu = false
            }
//        }
    }
    
}



struct SleepTimeView: PreviewProvider {
    static var previews: some View {
        SleepResultView()
    }
}
