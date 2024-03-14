//
//  RegistrationView.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/5/24.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var age = ""
    @State private var height = ""
    @State private var weight = ""
    @State private var selectedActivityLevel: ActivityLevel = .sedentary
    @State private var selectedGender: Gender = .male // Default selection
    @State private var loginView = false
    @State private var ageText: String = ""

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    enum ActivityLevel: Double, CaseIterable, Identifiable {
        case sedentary = 1.0
        case lightlyActive = 1.3
        case moderatelyActive = 1.6
        case veryActive = 2.0

        var id: Double { self.rawValue }

        var activityDescription: String {
            switch self {
            case .sedentary:
                return "Sedentary"
            case .lightlyActive:
                return "Lightly Active"
            case .moderatelyActive:
                return "Moderately Active"
            case .veryActive:
                return "Very Active"
            }
        }
    }
    
    enum Gender: String, CaseIterable, Identifiable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
        
        var id: String { self.rawValue }
    }

    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $loginView) {}
            
            ScrollView{
                VStack{
                    ZStack {
                        HStack {
                            Button {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                 generator.impactOccurred()
                                withAnimation(.spring()) {
                                    loginView.toggle()
                                }
                            } label : {
                                Label("", systemImage: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .padding(.top, 10)
                                    .padding(.leading, 20)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                    }
                    Image("loginPage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.bottom, 10)
                    
                    VStack(spacing: 24){
                        InputView(text: $fullname,
                                  title: "NAME",
                                  placeholder: "Enter your Full Name",
                                  image: "person",
                                  width: 20,
                                  height: 20)
                        
                        
                        //gender
                        VStack(spacing: 20) {
                            HStack{
                                Image(systemName: "figure.dress.line.vertical.figure")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(.leading, 5)
                                    .padding(.trailing, 5)
                                Text("Select your gender")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                             Picker("Gender", selection: $selectedGender) {
                                 ForEach(Gender.allCases) { gender in
                                     Text(gender.rawValue).tag(gender)
                                 }
                             }
                             .pickerStyle(SegmentedPickerStyle()) // Use SegmentedPickerStyle for a compact look

                             // Display the selection for demonstration
                             Text("Selected gender: \(selectedGender.rawValue)")
                                .foregroundColor(.white)
                         } .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(25)
                            .padding(.horizontal)
                        
                        
                        //age

                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(.leading, 5)
                                    .padding(.trailing, 5)
                                Text("Enter your age")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }

                            TextField("Select your Age", text: $age)
                                .keyboardType(.numberPad) // Suggest numeric keyboard
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.vertical, 8) // Reduced vertical padding for a skinnier look
                                .frame(height: 40) // Explicit height for skinniness
                                .background(Color.white)
                                .cornerRadius(8)
                                .onChange(of: age) { newValue in
                                    // Keep only numbers in the input
                                    age = newValue.filter { $0.isNumber }
                                }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(25)
                        .padding(.horizontal)

                        
                        //Height
                        VStack(spacing: 20) {
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "ruler")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                        .foregroundColor(.white)
                                        .padding(.leading, 5)
                                        .padding(.trailing, 5)
                                    Text("Enter your height (cm)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }

                                TextField("Enter your Height", text: $height)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 8)
                                    .frame(height: 40)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .onChange(of: height) { newValue in
                                        height = newValue.filter { $0.isNumber }
                                    }
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(25)
                            .padding(.horizontal)

                            // Weight input
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "scalemass")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                        .padding(.leading, 5)
                                        .padding(.trailing, 5)
                                    Text("Enter your weight (lbs)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }

                                TextField("Enter your Weight", text: $weight)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical, 8)
                                    .frame(height: 40)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .onChange(of: weight) { newValue in
                                        weight = newValue.filter { $0.isNumber }
                                    }
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(25)
                            .padding(.horizontal)
                        }

                        
                                            
                        // Activity Level
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(.leading, 5)
                                    .padding(.trailing, 5)
                                Text("Select your Activity Level")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            Picker("Activity Level", selection: $selectedActivityLevel) {
                                ForEach(ActivityLevel.allCases) { level in
                                    Text(level.activityDescription).tag(level)
                                }
                            }
                            Text("Selected Activity Level: \(selectedActivityLevel.activityDescription)")
                               .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(25)
                        .padding(.horizontal)


                        
                        
                        
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com",
                                  image: "envelope"
                        )
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  image: "lock",
                                  isSecure: true)
                        
                        
                        ZStack(alignment: .trailing){
                            InputView(text: $confirmPassword,
                                      title: "Confirm Password",
                                      placeholder: "Confirm your password",
                                      image: "lock",
                                      isSecure: true)
                            
                            if !password.isEmpty && !confirmPassword.isEmpty{
                                if password == confirmPassword{
                                    Image(systemName: "checkmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(.green)
                                } else{
                                    Image(systemName: "xmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    
                    
                    
                    Button {
                        Task{
                            try await viewModel.createUser(withEmail: email,
                                                           password: password,
                                                           fullname: fullname,
                                                           age: Int(age) ?? 0,
                                                           gender: selectedGender.rawValue,
                                                           height: Int(height) ?? 0,
                                                           weight: Int(weight) ?? 0,
                                                           activity: selectedActivityLevel.activityDescription,
                                                           water: 0,
                                                           pictures: []
                )}
                        
                    } label: {
                        HStack {
                            Text("SIGN UP")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        HStack (){
                            Text("Already have an account?")
                            Text("Sign in")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .font(.system(size:14))
                    }
                    
                }
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0), Color(red: 0.25, green: 0.30, blue: 0.59)]), startPoint: .top, endPoint: .bottom))
        }
    }
    
    
}

// Authentication Protocol
extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && Int(age) != 0
        && age != ""
        && height != ""
        && weight != ""
        && Int(height) != 0
        && Int(weight) != 0
        && !fullname.isEmpty
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
