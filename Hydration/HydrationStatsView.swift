//
//  HydrationStatsView.swift
//  Hydration
//
//  Created by Simar Cheema on 3/11/24.
//

import SwiftUI


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
                                
                                CircularWaterProgressView(progress: 1)
                                    .frame(width: 115, height: 105)
                                    .padding(.top, 13)
                                    .padding(.bottom, 30)
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(.white.opacity(0.2))
                            .cornerRadius(10)
                            .shadow(radius: 2)
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


#Preview {
    HydrationStatsView()
}
