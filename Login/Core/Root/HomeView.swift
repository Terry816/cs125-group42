//
//  ContentView2.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/5/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct HomeView: View{
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View{
        if viewModel.userSession == nil {
            NavigationStack {
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            Text("UniWell")
                                .foregroundColor(.white)
                                .font(.system(size: 30, weight: .heavy))
                            Spacer()
                        }
                        //Main body of app is here:
                        VStack {
                            LoginView()
                            Spacer()
                        }
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.14, green: 0.14, blue: 0.14), .black]), startPoint: .top, endPoint: .bottom))
            }
        }
        else {
            ProfileView()
            
        }
    }
}

struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView().environmentObject(AuthViewModel())
    }
}
