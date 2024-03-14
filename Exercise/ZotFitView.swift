//  Created by Simar Cheema on 2/11/24.
//
import SwiftUI
import HealthKit


var muscle = "biceps"
var etype = "strength"
var diff = ""

struct ZotFitView: View {
    
    @State var sideMenu = false
    @State var stepsView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: StepsView().navigationBarBackButtonHidden(true), isActive: $stepsView) {}
                VStack {
                    HStack(alignment: .center) {
                        ZStack {
                            HStack {
                                Button(action: {
                                    withAnimation(.spring()) {
                                        sideMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                        .foregroundColor(.white)
                                }
                                .padding([.leading])
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("Fitness")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .heavy))
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation(.spring()) {
                                        stepsView.toggle()
                                    }
                                }) {
                                    Image(systemName: "figure.walk.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                }.padding(.trailing)
                            }
                        }
                    }
                    //Main body of app is here:
                    VStack {
                        ExerciseTypeView()
                        Spacer()
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0.14, green: 0.14, blue: 0.14), .black]), startPoint: .top, endPoint: .bottom))
                .offset(x: sideMenu ? 250 : 0)
                .onTapGesture {
                    if sideMenu {
                        withAnimation {
                            sideMenu = false
                        }
                    }
                }
            }
            .onAppear {
                sideMenu = false
            }
        }
    }
}

#Preview {
    ZotFitView().environmentObject(AuthViewModel())
}
