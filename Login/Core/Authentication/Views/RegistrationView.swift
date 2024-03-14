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
    @State private var age: Int = 0
    @State private var gender = ""
    @State private var height = 0
    @State private var weight = 0
    @State private var selectedActivityLevel: ActivityLevel = .sedentary
    @State private var loginView = false
    @State private var isPickerPresented: Bool = false
    @State private var isPickerPresentedheight: Bool = false
    @State private var isPickerPresentedweight: Bool = false

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
                        
                        InputView(text: $gender,
                                  title: "GENDER",
                                  placeholder: "Enter your Gender",
                                  image: "person",
                                  width: 20,
                                  height: 20)
                        //age
                        VStack (alignment: .leading, spacing: 0){
                            
                            Text("Enter your age")
                                .foregroundColor(Color(.darkGray))
                                .fontWeight(.semibold)
                                .font(.footnote)
                            
                            TextField("Select your Age", value: $age, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 150)
                                .onTapGesture {
                                    isPickerPresented = true
                                }
                                .sheet(isPresented: $isPickerPresented) {
                                    agePickerView()
                                }
                            Divider()
                        }
                        
                        //height
                        VStack (alignment: .leading, spacing: 0){
                            Text("Enter your Height (cm)")
                                .foregroundColor(Color(.darkGray))
                                .fontWeight(.semibold)
                                .font(.footnote)
                            
                            TextField("Select your Height (cm)", value: $height, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 150)
                                .onTapGesture {
                                    isPickerPresentedheight = true
                                }
                                .sheet(isPresented: $isPickerPresentedheight) {
                                    heightPickerView()
                                }
                            Divider()
                        }
                        
                        //weight
                        VStack (alignment: .leading, spacing: 0){
                            Text("Enter your Weight (lbs)")
                                .foregroundColor(Color(.darkGray))
                                .fontWeight(.semibold)
                                .font(.footnote)
                            
                            TextField("Select your Weight (lbs)", value: $weight, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 150)
                                .onTapGesture {
                                    isPickerPresentedweight = true
                                }
                                .sheet(isPresented: $isPickerPresentedweight) {
                                    weightPickerView()
                                }
                            Divider()
                        }
                        
                        //activity level
                        VStack(spacing: 0){
                            Text("Enter your Activity Level")
                                .foregroundColor(Color(.darkGray))
                                .fontWeight(.semibold)
                                .font(.footnote)
                            
                            Picker("Select Activity Level", selection: $selectedActivityLevel) {
                                ForEach(ActivityLevel.allCases) { level in
                                    Text(level.activityDescription).tag(level)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .padding()
                            
                        }
                        
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
                                                           age: age,
                                                           gender: gender,
                                                           height: height,
                                                           weight:weight,
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
    
    
    func agePickerView() -> some View {
        return VStack {
            Text("Select your Age")
                .font(.headline)
                .padding()

            Picker("Age", selection: $age) {
                ForEach(1...100, id: \.self) { value in
                    Text("\(value)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .padding()

            Button("Done") {
                isPickerPresented = false
            }
            .padding()
        }
        
    }
    
    func heightPickerView() -> some View {
        return VStack {
            Text("Select your Height (cm)")
                .font(.headline)
                .padding()
            
            Picker("Height", selection: $height) {
                ForEach(1...300, id: \.self) { value in
                    Text("\(value)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .padding()
            
            Button("Done") {
                isPickerPresentedheight = false
            }
            .padding()
        }
    }
    
    func weightPickerView() -> some View {
        return VStack {
            Text("Select your weight (lbs)")
                .font(.headline)
                .padding()
            
            Picker("Weight", selection: $weight) {
                ForEach(1...500, id: \.self) { value in
                    Text("\(value)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .padding()
            
            Button("Done") {
                isPickerPresentedweight = false
            }
            .padding()
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
        && age != 0
        && height != 0
        && weight != 0
        && !fullname.isEmpty
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
