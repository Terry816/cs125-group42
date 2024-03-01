//  Created by Simar Cheema on 2/11/24.
//
import SwiftUI

var muscle = "biceps"
var etype = "strength"
var diff = ""

struct ZotFitView: View {
    @State var sideMenu = false
    var body: some View {
        NavigationView {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
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
                                Text("ZotFit")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .heavy))
                                Spacer()
                            }
                        }
                    }
                    //Main body of app is here:
                    VStack {
                        Spacer()
                        ExerciseTypeView()
                        Spacer()
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0.81), Color(red: 0, green: 0, blue: 0.5)]), startPoint: .top, endPoint: .bottom))
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
    ZotFitView()
}
