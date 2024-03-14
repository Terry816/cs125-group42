//
//  SleepCalcView.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/2/24.
//

import Foundation
import SwiftUI

func calculateBedtime(displayTime: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"

    guard let wakeUpDate = dateFormatter.date(from: displayTime) else {
        return "Invalid wake-up time format"
    }

    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: wakeUpDate)

    // Assuming you want to sleep for 7-9 hours
    if let bedtime = calendar.date(byAdding: .minute, value: -480, to: calendar.date(from: components) ?? Date()) {
        return dateFormatter.string(from: bedtime)
    } else {
        return "Error calculating bedtime"
    }
}

func calculateSecondBedtime(displayTime: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"

    guard let wakeUpDate = dateFormatter.date(from: displayTime) else {
        return "Invalid wake-up time format"
    }

    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: wakeUpDate)

    // Assuming you want to sleep for 7-9 hours
    if let bedtime = calendar.date(byAdding: .minute, value: -390, to: calendar.date(from: components) ?? Date()) {
        return dateFormatter.string(from: bedtime)
    } else {
        return "Error calculating bedtime"
    }
}

struct SleepCalcView: View {
    
    @Binding var displayTime: Date
    @State private var sideMenu = false
    @State private var sleepResult = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: SleepResultView().navigationBarBackButtonHidden(true), isActive: $sleepResult) {}
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
                    //Main body of app is here:
                    VStack {
                        ZStack {
                            HStack {
                                Button {
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                    withAnimation(.spring()) {
                                        sleepResult.toggle()
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
                                Text("Bedtime Options")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .padding()
                                .foregroundStyle(.black)
                            }
                        }
                        Spacer()
                        VStack {
                            HStack{
                                Text("To wake up refreshed at \(formattedTime(from: displayTime)), we recommend going to sleep at one of the following times:")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 18, design: .rounded))
                                    .foregroundStyle(.black)
                                    .padding(.horizontal)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Suggested")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .padding(.bottom, 10)
                                
                                HStack{
                                    VStack(alignment: .leading){
                                        
                                        HStack{
                                            Image(systemName: "moon.fill")
                                                .font(.system(size: 20))
                                                .padding(.horizontal,10)
                                                

                                            VStack{
                                                Text(calculateBedtime(displayTime: formattedTime(from: displayTime)))
                                                    .font(.system(size: 18))
                                                    .padding(.horizontal,10)

                                                Text("Bedtime")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding(.horizontal, 8)
                                            .padding(.top, 15)
                                        }

                                        
                                        Text("    |")
                                            .padding(.bottom, 5)
                                
                                        HStack{
                                            Image(systemName: "zzz")
                                                .font(.system(size: 26))
                                                .padding(.horizontal,10)
                                            
                                            VStack{
                                                Text(formattedTime(from: displayTime))
                                                    .font(.system(size: 18))
                                                
                                                Text("Wake Time")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding(.horizontal, 8)
                                        }
                                    }
                                    
                                    CircularTimeView(progress: 1)
                                        .frame(width: 115, height: 105)
                //                        .padding(.top, 13)
                                }
                                .padding(.bottom, 15)
                //                            .padding(.horizontal, 10)
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
                            
                            VStack(alignment: .leading) {
                                Text("Alternative")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .padding(.bottom, 10)
                                
                                HStack{
                                    
                                    VStack(alignment: .leading){
                                        
                                        HStack{
                                            Image(systemName: "moon.fill")
                                                .font(.system(size: 20))
                                                .padding(.horizontal,10)
                                                

                                            VStack{
                                                Text(calculateSecondBedtime(displayTime: formattedTime(from: displayTime)))
                                                    .font(.system(size: 18))
                                                    .padding(.horizontal,10)

                                                Text("Bedtime")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary) // Lighter text color
                                            }
                                            .padding(.horizontal, 8)
                                            .padding(.top, 15)
                                        }

                                        
                                        Text("    |")
                                            .padding(.bottom, 5)
                                
                                        HStack{
                                            Image(systemName: "zzz")
                                                .font(.system(size: 26))
                                                .padding(.horizontal,10)
                                            
                                            VStack{
                                                Text(formattedTime(from: displayTime))
                                                    .font(.system(size: 18))
                                                
                                                Text("Wake Time")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding(.horizontal, 8)
                                        }
                                    }
                                    CircularTimeView(progress: 2)
                                        .frame(width: 115, height: 105)
                                }
                                .padding(.bottom, 15)
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
                        }
                        Spacer()
                    }
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

struct SleepLastView: PreviewProvider {
    @State private static var displayTime = Date()
    static var previews: some View {
        SleepCalcView(displayTime: $displayTime)
    }
}

struct CircularTimeView: View {
  let progress: CGFloat

  var body: some View {
    ZStack {
      // Background for the progress bar
      Circle()
        .stroke(lineWidth: 7)
        .opacity(0.1)
        .foregroundColor(.black)

      // Foreground or the actual progress bar
      Circle()
        .trim(from: 0.0, to: min(progress, 1.0))
        .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
        .foregroundColor(progress == 1 ? Color.green : Color.yellow)
        .rotationEffect(Angle(degrees: 270.0))
        .animation(.linear, value: progress)
        
        VStack{
            Text(progress == 1 ? "5 Sleep" : (progress == 2 ? "4 Sleep" : ""))
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold, design: .rounded))
            
            Text("Cycles")
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold, design: .rounded))
        }
    }
  }
}

