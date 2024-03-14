//
//  WaterSelection.swift
//  Hydration
//
//  Created by Joanne Wang on 3/13/24.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct WaterIntakeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var sideMenu = false
    @State private var hydrationStats = false
    //to test comment the below and also comment out on UserView file
//    let user = User.MOCK_USER

    var body: some View {
        
        let user = viewModel.currentUser

        NavigationStack {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: HydrationStatsView().navigationBarBackButtonHidden(true), isActive: $hydrationStats) {}
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
                    ZStack {
                        HStack {
                            Button {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                 generator.impactOccurred()
                                withAnimation(.spring()) {
                                    hydrationStats.toggle()
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
                            Text("Select Water Amount")
                                .font(.system(size: 24, weight: .bold))
                                .padding(.top, 10)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                    }
                    Spacer()
                    //Main body of app is here:
                    VStack {
                        Spacer()
                        VStack {
                    
                            HStack{
                                Spacer()
                                Text("Glass of Water")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .bold))
                                    .padding(.top, 10)
                                    
                                Spacer()
                                Text("Water Bottle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24, weight: .bold))
                                    .padding(.top, 10)
                                    
                                Spacer()
                            }
                            
                            
                            // Horizontal stack to place icons side by side
                            HStack(spacing: 40) {
                                Spacer()
                                // Glass of water button
                                VStack {
                                    Button(action: {
                                        hydrationStats.toggle()
                                        guard let user = user else {
                                                    return
                                                }
                                                
                                                // Extract the current water value
                                                let currentWater = user.water
                                                
                                                // Add 8 ounces of water to the existing amount
                                                let newWater = currentWater + 8
                                                
                                                // Call the update user attribute function asynchronously within the view
                                                Task {
                                                    do {
                                                        try await viewModel.updateUserAttributes(water: Double(newWater))
                                                    } catch {
                                                        // Handle error here
                                                        print("Error updating user attributes: \(error)")
                                                    }
                                                }
                                    }) {
                                        VStack {
                                            Image("glassofwater")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 105, height: 105)
                                                .cornerRadius(15)
                                            Text("8 oz")
                                            
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                                
                                
                                // Water bottle button
                                VStack {
                                    Button(action: {
                                        hydrationStats.toggle()
                                        guard let user = user else {
                                                    return
                                                }
                                                
                                                // Extract the current water value
                                                let currentWater = user.water
                                                
                                                // Add 8 ounces of water to the existing amount
                                                let newWater = currentWater + 16
                                                
                                                // Call the update user attribute function asynchronously within the view
                                                Task {
                                                    do {
                                                        try await viewModel.updateUserAttributes(water: Double(newWater))
                                                    } catch {
                                                        // Handle error here
                                                        print("Error updating user attributes: \(error)")
                                                    }
                                                }
                                        
                                    }) {
                                        VStack {
                                            Image("waterb")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 105, height: 105)
                                                .cornerRadius(15)
                                            Text("16 oz")
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding(.bottom, 200)
                        Spacer()
                    }
                }
                //                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0.91), Color(red: 1, green: 0, blue: 0.75)]), startPoint: .top, endPoint: .bottom))
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
        //end of mainbody
        
        
    }
    

    
}

#Preview {
    WaterIntakeView().environmentObject(AuthViewModel())
}
