//
//  AuthViewModel.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/5/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool {get}
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    
    @Published var errorMessage: String? = nil

        func signIn(withEmail email: String, password: String) async {
            errorMessage = nil // Reset error message
            do {
                let result = try await Auth.auth().signIn(withEmail: email, password: password)
                self.userSession = result.user
                await fetchUser()
            } catch {
                // Update errorMessage based on the error
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to sign in. Please check your email and password and try again."
                }
            }
        }
    
    func createUser(withEmail email: String, password: String, fullname: String, age: Int, gender: String, height: Int, weight: Int, activity: String, water: Double, pictures: [String]) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email, age: age, gender: gender, height: height, weight: weight, activity: activity, water: water, pictures: pictures)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    
    func signOut(){
        do {
            print("In here")
            try Auth.auth().signOut() //signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out current user object
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount(){
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        
    }
    
    func updateUserAttributes(age: Int? = nil, gender: String? = nil, height: Int? = nil, weight: Int? = nil, activity: String? = nil, water: Double? = nil, pictures: [String]? = nil) async throws {
        guard let currentUser = self.currentUser else {
            print("No current user found.")
            return
        }

        let userRef = Firestore.firestore().collection("users").document(currentUser.id)

        var updatedData: [String: Any] = [:]

        if let age = age {
            updatedData["age"] = age
        }

        if let gender = gender {
            updatedData["gender"] = gender
        }

        if let height = height {
            updatedData["height"] = height
        }

        if let weight = weight {
            updatedData["weight"] = weight
        }

        if let activity = activity {
            updatedData["activity"] = activity
        }

        if let water = water {
            updatedData["water"] = water
        }

        if let pictures = pictures {
            updatedData["pictures"] = pictures
        }

        do {
            try await userRef.setData(updatedData, merge: true)
            // Refresh current user data after update
            await fetchUser()
            print("User attributes updated successfully.")
        } catch {
            print("Failed to update user attributes: \(error.localizedDescription)")
        }
    }

    
}
