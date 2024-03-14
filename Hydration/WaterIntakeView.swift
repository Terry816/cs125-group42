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
    
    //to test comment the below and also comment out on UserView file
//    let user = User.MOCK_USER

    var body: some View {
        
        let user = viewModel.currentUser
//        let user = User.MOCK_USER
        //main body
        VStack {
            
            Text("Select Your Cup Size")
                .font(.title)
                .bold()
            
            HStack{
                Spacer()
                Text("Glass of Water")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
                Text("Water Bottle")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            
            
            // Horizontal stack to place icons side by side
            HStack(spacing: 40) {
                Spacer()
                // Glass of water button
                VStack {
                    Button(action: {
                        print("8 Ounces")
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
                            Text("8 oz")
                            
                        }
                    }
                }
                
                Spacer()
                
                
                
                // Water bottle button
                VStack {
                    Button(action: {
                        
                        print("8 Ounces")
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
                            Text("16 oz")
                        }
                    }
                }
                Spacer()
            }
            
        }
        .navigationTitle("Cup Size")
        //end of mainbody
        
        
    }
    

    
}

#Preview {
    WaterIntakeView()
}
