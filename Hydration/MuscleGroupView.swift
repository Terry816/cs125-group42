//
//  MuscleGroupView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/26/24.
//

import SwiftUI

struct MuscleGroupView: View {
    @Binding var type: String
    @State var muscle: String = ""
    
    @State var sideMenu = false
    @State var muscleView = false
    @State var exerciseView = false
    var body: some View {
        NavigationView {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: ZotFitView().navigationBarBackButtonHidden(true), isActive: $exerciseView) {}
                NavigationLink(destination: ExerciseDifficultyView(type: $type, muscle: $muscle).navigationBarBackButtonHidden(true), isActive: $muscleView) {}
                VStack {
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
                    //Main body of app is here:
                    VStack {
                        Spacer()
                        VStack
                        {
                            ZStack {
                                HStack {
                                    Button {
                                        withAnimation(.spring()) {
                                            exerciseView.toggle()
                                        }
                                    } label : {
                                        Label("", systemImage: "arrow.left")
                                            .font(.system(size: 22, weight: .bold))
                                            .padding(.top, 10)
                                            .padding(.leading, 10)
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Spacer()
                                    Text("Select exercise type")
                                        .font(.system(size: 24, weight: .bold))
                                        .padding(.top, 10)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                            }
                                
                            Spacer()
                            
                            ScrollView {
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "abdominals"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("abs")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Abs")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.gray)
                                .cornerRadius(40)
                                .padding(10)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "biceps"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("biceps")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Biceps")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "calves"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("calves")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Calves")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "chest"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("chest")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Chest")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "forearms"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("forearms")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Forearms")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "hamstrings"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("hamstring")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Hamstring")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "lats"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("lats")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Lats")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "middle_back"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("middleback")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Back")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "quadriceps"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("quads")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Quads")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                                Spacer()
                                
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        muscle = "triceps"
                                        muscleView.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image("triceps")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .background(.white)
                                            .cornerRadius(40)
                                        Spacer()
                                        Text("Triceps")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.white)
                                            .padding(.bottom, 5)
                                        Spacer()
                                        Image(systemName: "chevron.right") // Navigation arrow symbol
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                            .padding(.trailing)
                                    }
                                }
                                .buttonStyle(.bordered)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .background(.black)
                                .cornerRadius(40)
                                .padding(5)
                                
                            }
                            .padding(.top, 20)
                        }
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

struct MuscleGroupView_Preview: PreviewProvider {
  @State static var type = ""
  static var previews: some View {
      MuscleGroupView(type: $type)
  }
}
