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
    @State private var showingConfirmation = false

    
    @EnvironmentObject var viewModel: AuthViewModel
    
    //to test comment the below and also comment out on UserView file
//    let user = User.MOCK_USER
//    
//    var waterIntake : Double { 
//        return calculateWaterIntake(age: user.age, activityLevel: user.activity, gender: user.gender, weightInPounds: Double(user.weight))
//    }
//    
//    var percent : Double {
//        return calculateWaterPercentage(userWater: user.water, totalWaterIntake: waterIntake)
//    }
    
    

    
    var body: some View {
        //comment this out if you are testing and want to see preview

        let user = viewModel.currentUser
        
        var waterIntake : Double {
            return calculateWaterIntake(age: user?.age ?? 0, activityLevel: user?.activity ?? "Sedentary", gender: user?.gender ?? "Male", weightInPounds: Double(user?.weight ?? 250))
        }
        
        var percent : Double {
            return calculateWaterPercentage(userWater: user?.water ?? 0, totalWaterIntake: waterIntake)
        }
//
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
                                Text("Water")
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
                            VStack {
                                
                                HStack(spacing: 0) {
                                    HStack{
                                        Text(String(user?.water ?? 0))
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
                                    .border(Color.gray, width: 0.5)
                                    .foregroundColor(.white)
                                    .background(Color.white.opacity(0.2))
                                    

                                    HStack{
                                       Text(String(waterIntake))
                                            .font(.system(size: 40, weight: .bold, design: .rounded))
                                            .padding(.top, 10)
                                            .padding(.bottom, 10)
                                            .foregroundColor(Color.blue)
   
                                       VStack{
                                           Text("Goal")
                                               .font(.system(size: 16, weight: .bold, design: .rounded))
                                               .padding(.bottom, -15)
                                               .foregroundColor(.white)
                                           
                                           Text("fl oz")
                                               .font(.system(size: 30, weight: .bold, design: .rounded))
                                               .foregroundColor(Color.blue)
                                       }
                                   }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .background(Color.white.opacity(0.2))
                                    .border(Color.gray, width: 0.5)
                                }
                                    .frame(minWidth: 0, maxWidth: .infinity)

                            }

                            //water progress bar
                            VStack{
                                Text("Water Progress")
                                    .padding()
                                    .padding(.bottom, 10)
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                CircularWaterProgressView(progress: percent)
                                    .frame(width: 300, height: 250)
                                    .padding(.top, 13)
                                    .padding(.bottom, 30)
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            
                            Spacer()
                            HStack{
                                //Add water button
                                Spacer()
                                NavigationLink(destination: WaterIntakeView().navigationBarBackButtonHidden()) {
                                    Text("Add Water")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                                .buttonStyle(PlainButtonStyle())
                                Spacer()
                                
                                Button(action: {
                                    // Show confirmation dialog
                                    showingConfirmation = true
                                }) {
                                    Text("Clear")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                                .alert(isPresented: $showingConfirmation) {
                                    Alert(
                                        title: Text("Are you sure?"),
                                        message: Text("This will clear all water from your intake."),
                                        primaryButton: .default(Text("Yes")) {
                                            // Clear water action
                                            clearWater()
                                        },
                                        secondaryButton: .cancel(Text("Cancel"))
                                    )
                                }
                                
                                
                                Spacer()
                            }
                        
                            
                            
                            Spacer()
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
    
    func clearWater() {
            // Clear water action
            Task {
                do {
                    try await viewModel.updateUserAttributes(water: 0)
                } catch {
                    // Handle error here
                    print("Error updating user attributes: \(error)")
                }
            }
    }
    
}




func calculateWaterIntake(age: Int, activityLevel: String, gender: String, weightInPounds: Double) -> Double {
    var baseWaterIntake: Double = 0
    
    // Determine base water intake based on age and gender
    if age >= 1 && age <= 3 {
        baseWaterIntake = 44
    } else if age >= 4 && age <= 8 {
        baseWaterIntake = 56
    } else if age >= 9 && age <= 13 {
        baseWaterIntake = 64
    } else if age >= 14 && age <= 18 {
        baseWaterIntake = gender.lowercased() == "male" ? 125 : 91
    } else if age >= 19 {
        baseWaterIntake = gender.lowercased() == "male" ? 125 : 91
    } else {
        // Handle invalid age
        return 0
    }
    
    switch activityLevel {
    case "Sedentary":
        baseWaterIntake *= 1.0
    case "Lightly Active":
        baseWaterIntake *= 1.1
    case "Moderately Active":
        baseWaterIntake *= 1.3
    case "Very Active":
        baseWaterIntake *= 1.5
    default:
        return 0
    }
    
    return baseWaterIntake
}


func calculateWaterPercentage(userWater: Double, totalWaterIntake: Double) -> Double {
    guard totalWaterIntake > 0 else {
        return 0.0 // Avoid division by zero
    }
    
    // Calculate the percentage
    let percentage = userWater / totalWaterIntake
    
    if percentage >= 1{
        return 1
    } else{
        return percentage
    }
            
}





#Preview {
    HydrationStatsView().environmentObject(AuthViewModel())
}
