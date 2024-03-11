//
//  SwiftUIApp.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/5/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

@main
struct SwiftUIApp: App {
    @StateObject var viewModel = AuthViewModel()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene{
        WindowGroup{
            HomeView()
                .environmentObject(viewModel)
        }
    }
}


//todo -> make image selection and save images to cloud
// make fields modifiable through the homepage
//make error handling for sign in to nonexisting user
// make the initals correct
