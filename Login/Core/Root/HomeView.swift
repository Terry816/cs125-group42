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
                        //Main body of app is here:
                        VStack {
                            LoginView()
                            Spacer()
                        }
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0), Color(red: 0.25, green: 0.30, blue: 0.59)]), startPoint: .top, endPoint: .bottom))
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
