//
//  ScoreView.swift
//  Hydration
//
//  Created by Joanne Wang on 3/12/24.
//

import Foundation
import SwiftUI

struct ScoreView: View {
    @State var progressValue: Float = 0.49 // SLEEP SCORE
    @State private var degress: Double = -100
    
    @State private var sideMenu = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                if sideMenu {
                    SideMenuView()
                }
                
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
                    .background(Color(red: 0.14, green: 0.14, blue: 0.14))
                    Spacer()
                    VStack {
                        
                        ZStack {
                            ProgressBar(progress: self.$progressValue)
                                .frame(width: 250.0, height: 250.0)
                                .padding(40.0)
                            
                            ProgressBarTriangle(progress: self.$progressValue)
                                .frame(width: 280.0, height: 290.0)
                                .rotationEffect(.degrees(degress), anchor: .bottom)
                                .offset(x: 0, y: -150)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            
                            Divider()
                            
                            Text("Score Breakdown by Health Domain")
                                .padding()
                            
                            Divider()
                            
                            HStack{
                                Image(systemName: "drop.fill")
                                Text("Water")
                                Spacer()
                                Text("70")
                            }
                            .padding()
                            
                            Divider()
                            
                            HStack{
                                Image(systemName: "bed.double.fill")
                                Text("Sleep")
                                Spacer()
                                Text("70")
                            }
                            .padding()
                            
                            Divider()
                            
                            HStack{
                                Image(systemName: "heart.fill")
                                Text("Fit")
                                Spacer()
                                Text("70")
                            }
                            .padding()
                            
                            Divider()
                        }
                        .padding()
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                    }
                    Spacer()
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
            }
            .onAppear {
                sideMenu = false
            }
        }
    }
    
    
    struct ProgressBar: View {
        @Binding var progress: Float
        
        var body: some View {
           
            VStack{
                
                VStack{
                    Text("Lifestyle Score")
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                }
                .padding()
                
                VStack{
                    ZStack {
                        Circle()
                            .trim(from: 0.25, to: 0.75) // Trim the outer circle to create a semi-circle
                            .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                            .opacity(0.3)
                            .foregroundColor(Color.gray)
                            .rotationEffect(.degrees(90))
                        
                        Circle()
                            .trim(from: 0.25, to: CGFloat(self.progress) * 0.5 + 0.25)
                            .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                            .rotationEffect(.degrees(90))
                            .foregroundColor(progressColor(progress))
                        
                        VStack{
                            Text("\(Int(progress * 100))").font(Font.system(size: 44)).bold()
                            
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 2)
                            
                            HStack{
                                Text("Your Score is")
                                Text(scoreDescription(for: Double(progress) * 100))
                                    .foregroundColor(scoreColor(for: Double(progress) * 100))
                            }
                            .padding(.top, 5)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            
                        }
                        .padding(.top, 15)
                    }
                }
            }
            
        }
    }
    
    struct ProgressBarTriangle: View {
        @Binding var progress: Float
        
        
        var body: some View {
            ZStack {
                Image("triangle").resizable().frame(width: 10, height: 10, alignment: .center)
            }
        }
    }
}

func scoreDescription(for score: Double) -> String {
    if score < 50 {
        return "Bad"
    } else if score >= 50 && score < 80 {
        return "OK"
    } else {
        return "Great"
    }
}

func scoreColor(for score: Double) -> Color {
    if score < 50 {
        return .red
    } else if score >= 50 && score < 80 {
        return .orange
    } else {
        return .green
    }
}

private func progressColor(_ progress: Float) -> Color {
    let scaledProgress = progress * 100 // Scale progress to 0-100 range
        switch scaledProgress {
            case ..<50:
                return .red
            case 50..<80:
                return .orange
            case 80...100:
                return .green
            default:
                return .gray
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
