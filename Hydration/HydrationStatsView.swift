//
//  HydrationStatsView.swift
//  Hydration
//
//  Created by Simar Cheema on 3/11/24.
//

import SwiftUI
import Foundation


let activityLevelValues: [String: Double] = [
    "Sedentary": 1.0,
    "Lightly Active": 1.3,
    "Moderately Active": 1.6,
    "Very Active": 2.0
]


struct HydrationStatsView: View {
    @State var sideMenu = false
    @State var hydrationView = false
    
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    //to test comment the below and also comment out on UserView file
    let user = User.MOCK_USER
    
    var wt : Double {
        return waterc(weightInLbs: Double(user.weight), activityLevel: user.activity)
    }
    
    
    //comment this out if you are testing and want to see preview
//    var user: User? {
//        viewModel.currentUser
//    }
    
//    var goal: Double {
//        if let user = user {
//            return calculateWaterIntake(weightInLbs: Double(user.weight), heightInCm: Double(user.height), age: user.age, gender: user.gender, activityLevel: user.activity)
//        }
//        return 0.0
//    }

//    var goal: Double {
//            return calculateWaterIntake(weightInLbs: Double(user.weight), heightInCm: Double(user.height), age: user.age, gender: user.gender, activityLevel: user.activity)
//        }
    
    

    
    var body: some View {
        
        NavigationStack {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: HydrationView().navigationBarBackButtonHidden(true), isActive: $hydrationView) {}
                VStack {
                    HStack(alignment: .center) {
                        ZStack {
                            HStack {
                                Button(action: {
                                    withAnimation(.spring()) {
                                        sideMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                        .foregroundColor(.white)
                                }
                                .padding([.leading])
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("ZotWater")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .heavy))
                                Spacer()
                            }
                        }
                    }
                    

                    
                    //Main body of app is here:
                    VStack {
                        ZStack {
                            HStack {
                                Button {
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                     generator.impactOccurred()
                                    withAnimation(.spring()) {
                                        hydrationView.toggle()
                                    }
                                } label : {
                                    Label("", systemImage: "arrow.left")
                                        .font(.system(size: 22, weight: .bold))
                                        .padding(.top, 10)
                                        .padding(.leading, 10)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("Daily Water Intake")
                                    .font(.system(size: 24, weight: .bold))
                                    .padding(.top, 10)
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                        }
                        
                        VStack{
                            HStack {
                                Text("Goal for the Day:")
                                    .padding()
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                VStack{
//                                    Text(String(goal))
                                    Text(String(wt))
                                    Text("ounces")
                                }
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .padding(.trailing)
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(.white.opacity(0.2))
                            .cornerRadius(10)
                            .shadow(radius: 2)

                            VStack{
                                Text("Water Progress")
                                    .padding()
                                    .padding(.bottom, 10)
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                
                                CircularWaterProgressView(progress: 0.5)
                                    .frame(width: 115, height: 105)
                                    .padding(.top, 13)
                                    .padding(.bottom, 30)
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(.white.opacity(0.2))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            
                            
                            //------------------------------------------------------
                            
//                            VStack{
//        //                        Spacer()
//                                NavigationLink(destination: WaterMeasure()) {
//                                    Text("Add Drink")
//                                        .padding()
//                                        .background(Color(red: 0.14, green: 0.14, blue: 0.14))
//                                        .foregroundColor(.white)
//                                        .cornerRadius(10)
//                                        .font(.system(size: 20, weight: .bold, design: .rounded))
//                                }
//                                
//                                Spacer()
//                            }
                            
                            
                            
                            //------------------------------------------------------
                            // A standard glass contains 8 ounces, and one gallon equals sixteen glasses (each glass has 8 ounces) of water. For daily intake, the general guidelines recommend around 8 glasses or 64 ounces for water.
                            Spacer()

                            VStack {
                                HStack(spacing: 0) {
                                    HStack{
                                       Text("0")
                                           .font(.system(size: 40, weight: .bold, design: .rounded))
                                           .padding(.top, 10)
                                           .padding(.bottom, 10)
                                           .foregroundColor(Color.blue)
   
                                       VStack{
                                           Text("Now")
                                               .font(.system(size: 16, weight: .bold, design: .rounded))
                                               .padding(.bottom, -15)
                                           
                                           Text("OZ")
                                               .font(.system(size: 30, weight: .bold, design: .rounded))
                                               .foregroundColor(Color.blue)
                                       }
                                   }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .background(Color.white)
                                    .border(Color.gray, width: 1)

                                    HStack{
                                       Text(String(wt))
                                            .font(.system(size: 40, weight: .bold, design: .rounded))
                                            .padding(.top, 10)
                                            .padding(.bottom, 10)
                                            .foregroundColor(Color.blue)
   
                                       VStack{
                                           Text("Goal")
                                               .font(.system(size: 16, weight: .bold, design: .rounded))
                                               .padding(.bottom, -15)
                                           
                                           Text("OZ")
                                               .font(.system(size: 30, weight: .bold, design: .rounded))
                                               .foregroundColor(Color.blue)
                                       }
                                   }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .background(Color.white)
                                    .border(Color.gray, width: 1)
                                }
                                    .frame(minWidth: 0, maxWidth: .infinity)

                            }
                            //------------------------------------------------------
                            
                        }
                        .padding(.top, 25)
                        Spacer()
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.14, green: 0.14, blue: 0.14), .black]), startPoint: .top, endPoint: .bottom))
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


//this is the incorrect functoin from gpt
//func calculateWaterIntake(weightInLbs: Double, heightInCm: Double, age: Int, gender: String, activityLevel: String) -> Double {
//    let lbsToKgConversionFactor: Double = 2.20462
//    let litersToFluidOuncesConversionFactor: Double = 33.814
//    let baseWaterIntakePerKg: Double = 0.03
//    
//    // Convert weight to kilograms
//    let weightInKg = weightInLbs / lbsToKgConversionFactor
//    
//    // Convert height to meters
//    let heightInMeters = heightInCm / 100.0
//    
//    // Retrieve activity multiplier from dictionary
//    let activityMultiplier: Double = activityLevelValues[activityLevel] ?? 1.0
//
//    // Calculate BMR based on gender
//    var bmr: Double
//    if gender == "Male" {
//        bmr = 10 * weightInKg + 6.25 * heightInMeters - 5 * Double(age) + 5
//    } else if gender.lowercased() == "female" {
//        bmr = 10 * weightInKg + 6.25 * heightInMeters - 5 * Double(age) - 161
//    } else {
//        bmr = 10 * weightInKg + 6.25 * heightInMeters - 5 * Double(age) + 2
//    }
//
//    // Adjust BMR based on activity level
//    let totalDailyEnergyExpenditure = bmr * activityMultiplier
//
//    // Calculate water intake in liters
//    let waterIntakeLiters = totalDailyEnergyExpenditure * baseWaterIntakePerKg
//
//    // Convert water intake to fluid ounces
//    let waterIntakeFluidOunces = waterIntakeLiters * litersToFluidOuncesConversionFactor
//
//    return waterIntakeFluidOunces
//}

func waterc (weightInLbs: Double, activityLevel: String) -> Double{
    let w = weightInLbs / 2
    
    let activityMultiplier: Double = activityLevelValues[activityLevel] ?? 1.0
    
    return w * activityMultiplier
    
}

//func displayWaterBottle(filledPercentage: Double) {
//    let totalRows = 20
//    let filledRows = Int((filledPercentage / 100.0) * Double(totalRows))
//
//    for row in 1...totalRows {
//        if row <= filledRows {
//            let percentage = Double(row) / Double(totalRows) * 100.0
//            let fillSymbol = getFillSymbol(percentage: percentage)
//            print(fillSymbol)
//        } else {
//            print("")
//        }
//    }
//    print("")
//}
//
//func getFillSymbol(percentage: Double) -> String {
//    if percentage <= 25.0 {
//        return "▓"
//    } else if percentage <= 50.0 {
//        return "▓▓"
//    } else if percentage <= 75.0 {
//        return "▓▓▓"
//    } else {
//        return "▓▓▓▓"
//    }
//}



#Preview {
    HydrationStatsView()
}
