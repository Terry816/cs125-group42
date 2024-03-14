import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore


struct UserView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var image: Image?
    @State private var isShowingImagePicker = false
    
    let circleSize: CGSize = CGSize(width: 150, height: 150)
    
    var body: some View {
        if let user = viewModel.currentUser {
            //                        let user = User.MOCK_USER
            ZStack {
                VStack {
                    Section{
                        HStack{
                            Spacer()
                            VStack(spacing: 20){
                                if let selectedImage = image {
                                    selectedImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.secondary, lineWidth: 4))
                                        .onTapGesture {
                                            self.isShowingImagePicker = true
                                        }
                                } else {
                                    Text(user.initials)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .frame(width: 100, height: 100)
                                        .background(Color(.systemGray3))
                                        .clipShape(Circle())
                                }
                                
                            }
                            .padding(.top, 10)
                            Spacer()
                        }
                        
                        
                        HStack{
                            Spacer()
                            VStack() {
                                Text(user.fullname)
                                    .font(.system(size: 34, weight: .heavy))
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 5)
                                
                                Text(user.email)
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                
                                Text("Upload photo")
                                    .foregroundColor(.blue)
                                    .padding(.top, 5)
                                    .onTapGesture {
                                        self.isShowingImagePicker = true
                                    }
                            }
                            Spacer()
                        }
                    }
                    Rectangle()
                        .fill(Color.white) // Sets the color of the divider to blue
                        .frame(height: 2)
                        .padding(.horizontal, 40)
                    
                    
                    List{
                        //age
                        Section("Age"){
                            Button{
                                print("Age")
                            } label: {
                                SettingsRowView(imageName: "calendar",
                                                title: "\(user.age)",
                                                tintColor: .black)
                            }
                        }
                        .foregroundColor(.white)
                        
                        // make a popup that the user can use to input their height
                        Section("Height"){
                            Button{
                                print("Height")
                            } label: {
                                SettingsRowView(imageName: "ruler",
                                                title: "\(user.height) cm",
                                                tintColor: .black)
                            }
                        }
                        .foregroundColor(.white)
                        
                        Section("Weight"){
                            Button{
                                print("Weight")
                            } label: {
                                SettingsRowView(imageName: "scalemass",
                                                title: "\(user.weight) lbs",
                                                tintColor: .black)
                            }
                        }
                        .foregroundColor(.white)
                        
                        Section("Gender"){
                            Button{
                                print("Gender")
                            } label: {
                                SettingsRowView(imageName: "figure.dress.line.vertical.figure",
                                                title: user.gender,
                                                tintColor: .black)
                            }
                        }
                        .foregroundColor(.white)
                        
                        Section("Activity Level"){
                            Button{
                                print("Activity Level")
                            } label: {
                                SettingsRowView(imageName: "figure.run",
                                                title: user.activity,
                                                tintColor: .black)
                            }
                        }
                        .foregroundColor(.white)
                        
                        Section("Account"){
                            Button{
                                print("Tap")
                                viewModel.signOut()
                            } label: {
                                SettingsRowView(imageName: "arrow.left.circle.fill",
                                                title: "Sign Out",
                                                tintColor: .red)
                            }
                        }
                        .foregroundColor(.white)
                    }
                    .scrollContentBackground(.hidden)
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
//            .background(.black)
        }
    }
}



struct UserView_Previews: PreviewProvider {

    static var previews: some View {
        UserView().environmentObject(AuthViewModel())
    }
}

