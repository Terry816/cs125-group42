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
    @State private var sleep = false
    @State private var sideMenu = false
    @State private var selectedTime = Date()
    @State private var displayTime = Date()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: ZotSleepView().navigationBarBackButtonHidden(true), isActive: $sleep) {}
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
                                    Text("Sleep")
                                        .foregroundColor(.white)
                                        .font(.system(size: 30, weight: .bold))
                                    Spacer()
                                }
                                .frame(height: 50)
                                Spacer()
                            }
                        }
                    }
                    .background(Color(red: 0.14, green: 0.14, blue: 0.14))
                    ZStack {
                        HStack {
                            Button {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                 generator.impactOccurred()
                                withAnimation(.spring()) {
                                    sleep.toggle()
                                }
                            } label : {
                                Label("", systemImage: "arrow.left")
                                    .font(.system(size: 22, weight: .bold))
                                    .padding(.top, 10)
                                    .padding(.leading, 10)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("Select Wake Up Time")
                                .font(.system(size: 24, weight: .bold))
                                .padding(.top, 10)
                                .foregroundStyle(.black)
                            Spacer()
                        }
                    }
                    VStack {
                        Spacer()
                        VStack {
                            Spacer()
                            Text("When do you want to wake up?")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundStyle(.black)
                            
                            //Main content goes here
                            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                .cornerRadius(30)
                                .datePickerStyle(.wheel)
                                .labelsHidden()
                                .onChange(of: selectedTime) { oldvalue, newValue in
                                    displayTime = newValue
                                }
                                
                            
                            
 
                            Spacer()
                        }

                        
                        VStack{
                            NavigationLink(destination: SleepCalcView(displayTime: $displayTime).navigationBarBackButtonHidden()) {
                                Text("Confirm Time: \(formattedTime(from:displayTime))")
                                    .padding()
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .background(Color(red: 0.14, green: 0.14, blue: 0.14))
                                    .cornerRadius(10)
                            }
                            Spacer()
                        }
                        .padding(.top, 30)
                    }
                    .padding(.top, 100)
                }
                .background(.white)
                .offset(x: sideMenu ? 300 : 0)
            }
            .onAppear {
                sideMenu = false
            }
        }
    }
}



struct SleepTimeView: PreviewProvider {
    static var previews: some View {
        SleepResultView()
    }
}
