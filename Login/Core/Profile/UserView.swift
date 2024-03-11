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
        NavigationStack {
            if let user = viewModel.currentUser {
                //        let user = User.MOCK_USER
                List{
                    Section{
                        HStack{
                            Spacer()
                            VStack(spacing: 20){
                                if let selectedImage = image {
                                    selectedImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 120)
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
                                        .frame(width: 120, height: 120)
                                        .background(Color(.systemGray3))
                                        .clipShape(Circle())
                                }
                                
                                
                                Text("Upload photo")
                                    .foregroundColor(.blue)
                                    .padding(EdgeInsets())
                                    .onTapGesture {
                                        self.isShowingImagePicker = true
                                    }
                            }
                            Spacer()
                        }
                        
                        
                        HStack{
                            Spacer()
                            VStack() {
                                
                                Text(user.fullname)
                                    .bold()
                                    .font(.title)
                                
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                        }
                        
                        
                    }
                    
                    
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
                    
                    Section("Weight"){
                        Button{
                            print("Weight")
                        } label: {
                            SettingsRowView(imageName: "scalemass",
                                            title: "\(user.weight) lbs",
                                            tintColor: .black)
                        }
                    }
                    
                    Section("Gender"){
                        Button{
                            print("Gender")
                        } label: {
                            SettingsRowView(imageName: "figure.dress.line.vertical.figure",
                                            title: user.gender,
                                            tintColor: .black)
                        }
                    }
                    
                    Section("Account"){
                        Button{
                            viewModel.signOut()
                            print("Trying to sign out")
                        } label: {
                            SettingsRowView(imageName: "arrow.left.circle.fill",
                                            title: "Sign Out",
                                            tintColor: .red)
                        }
                        
                    }
                }
                .background(Color.clear)
            }
        }
    }
}



struct UserView_Previews: PreviewProvider {

    static var previews: some View {
        UserView()
    }
}

