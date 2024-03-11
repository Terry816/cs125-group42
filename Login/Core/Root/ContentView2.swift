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

struct ContentView2: View{
    @StateObject var viewModel = AuthViewModel()
    
    var body: some View{
        Group{
            if viewModel.userSession != nil{
                ProfileView()
            } else{
                LoginView()
            }
        }
    }
}

struct ContentView2_Previews: PreviewProvider{
    static var previews: some View{
        ContentView2()
    }
}
