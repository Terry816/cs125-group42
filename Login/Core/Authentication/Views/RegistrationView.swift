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
    
    @State private var isPickerPresented: Bool = false
    @State private var isPickerPresentedheight: Bool = false
    @State private var isPickerPresentedweight: Bool = false

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                Image("temporary")
                    .resizable()
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 120)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24){
                    
                    InputView(text: $fullname,
                              title: "Full Name",
                              placeholder: "Enter your Full Name")
                    
                    InputView(text: $gender,
                              title: "Gender",
                              placeholder: "Enter your Gender")
                    
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
                    
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecure: true)
                    
                    
                    ZStack(alignment: .trailing){
                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Confirm your password",
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
                                                       weight:weight)
                    }
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
