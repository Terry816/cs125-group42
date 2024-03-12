//
//  LoginView.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/5/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View{
        ZStack {
            VStack{
                //image
                Image("hydration_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 120)
                    .padding(.vertical, 32)
                
                
                HStack {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.system(size: 35, weight: .heavy))
                        .padding(.leading, 40)
                        .padding(.bottom, 5)
                    Spacer()
                }
                
                HStack {
                    Text("Please sign in to continue.")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                        .padding(.leading, 40)
                        .padding(.bottom, 30)
                    Spacer()
                }
                
                //form fields
                VStack(spacing: 24){
                    InputView(text: $email,
                              title: "EMAIL",
                              placeholder: "name@example.com",
                              image: "envelope")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    InputView(text: $password,
                              title: "PASSWORD",
                              placeholder: "Enter your password",
                              image: "lock",
                              width: 20,
                              height: 25,
                              isSecure: true)
                }
//                .padding(.horizontal)
//                .background(.white)
                
                if let errorMessage = viewModel.errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                        .padding()
                                }
                
                //sing in button
                Button {
                        Task {
                            await viewModel.signIn(withEmail: email, password: password)
                        }
                    } label: {
                        Text("LOGIN")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 100)
                            .padding(.vertical, 30)
                    }
                    .background(.white)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.7)
                    .cornerRadius(100)
                    .padding(.top, 24)
                    
                    Spacer()
                
                //sign up button
                
                NavigationLink{
                    RegistrationView()
                } label: {
                    HStack (){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(.white)
                    .font(.system(size:16))
                }
            }
//            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.14, green: 0.14, blue: 0.14), .black]), startPoint: .top, endPoint: .bottom))
            .background(.clear)
        }
    }
}


// Authentication Protocol
extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
