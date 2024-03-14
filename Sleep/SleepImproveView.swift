//
//  SleepImproveView.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/13/24.
//

import SwiftUI

struct SleepRecommendation: Identifiable {
    let id = UUID()
    let ageGroup: String
    let recommendedHours: String
    let ageRange : Range<Int>
}

struct SleepImproveView: View {
    
    // --------------------------------------------------
    @EnvironmentObject var viewModel: AuthViewModel
    let user = User.MOCK_USER
    // --------------------------------------------------
    
    @State private var sideMenu = false
    @State private var sleep = false
    @Binding var progress: CGFloat
    
    let sleepRecommendations = [
            SleepRecommendation(ageGroup: "Newborn (0-3 months)", recommendedHours: "14-17 hours", ageRange: 0..<3),
            SleepRecommendation(ageGroup: "Infant (4-11 months)", recommendedHours: "12-15 hours", ageRange: 4..<12),
            SleepRecommendation(ageGroup: "Toddler (1-2 years)", recommendedHours: "11-14 hours", ageRange: 1..<3),
            SleepRecommendation(ageGroup: "Preschool (3-5 years)", recommendedHours: "10-13 hours", ageRange: 3..<6),
            SleepRecommendation(ageGroup: "School Age (6-13 years)", recommendedHours: "9-11 hours", ageRange: 6..<14),
            SleepRecommendation(ageGroup: "Teen (14-17 years)", recommendedHours: "8-10 hours", ageRange: 14..<18),
            SleepRecommendation(ageGroup: "Young Adult (18-25 years)", recommendedHours: "7-9 hours", ageRange: 18..<26),
            SleepRecommendation(ageGroup: "Adult (26-64 years)", recommendedHours: "7-9 hours", ageRange: 26..<65),
            SleepRecommendation(ageGroup: "Older Adult (65+ years)", recommendedHours: "7-8 hours", ageRange: 65..<Int.max)
        ]
    
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
                            Text("Sleep Quality")
                                .font(.system(size: 24, weight: .bold))
                                .padding(.top, 10)
                                .foregroundStyle(.black)
                            Spacer()
                        }
                    }
                    // put code ----------------------------
                    VStack {
                        
                        Spacer()
                        
                        VStack {
                            
                            Text("Your sleep quality score is \(Int(progress * 100))%")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            
                            Spacer()
                        }
                        
                    }
                    .padding(.top, 25)
                    
                    List(sleepRecommendations) { recommendation in
                        VStack(alignment: .leading) {
                            Text(recommendation.ageGroup)
//                                .font(.headline)
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            Text("Recommended Sleep: \(recommendation.recommendedHours)")
//                                .font(.subheadline)
                                .font(.system(size: 15, design: .rounded))
                        }
                        .background(recommendation.ageRange.contains(user.age) ? Color.yellow.opacity(0.3) : Color.clear)
                    }
                    // ------------------------------------
                }
                .offset(x: sideMenu ? 300 : 0)
            }
            .onAppear {
                sideMenu = false
            }
        }
    }
    
}

struct SleepImprove: PreviewProvider {
    @State private static var progress: CGFloat = 0.2
    static var previews: some View {
        SleepImproveView(progress: $progress)
    }
}
