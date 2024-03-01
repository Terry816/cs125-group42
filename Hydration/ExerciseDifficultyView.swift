//
//  ExerciseDifficultyView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/29/24.
//

import SwiftUI

struct ExerciseDifficultyView: View {
    @Binding var type: String
    @Binding var muscle: String
    
    @State var difficulty: String = ""
    @State var sideMenu = false
    @State var muscleView = false
    @State var exerciseSuggestion = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: MuscleGroupView(type: $type).navigationBarBackButtonHidden(true), isActive: $muscleView) {}
                NavigationLink(destination: ExerciseSuggestionView(type: $type, muscle: $muscle, difficulty: $difficulty).navigationBarBackButtonHidden(true), isActive: $exerciseSuggestion) {}
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
                                            muscleView.toggle()
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
                                    Text("Select exercise difficulty")
                                        .font(.system(size: 24, weight: .bold))
                                        .padding(.top, 10)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                            }
                            
                            Spacer()
                            
                            VStack {
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        difficulty = "beginner"
                                        exerciseSuggestion.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image(systemName: "staroflife.circle")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("Beginner")
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
                                .padding(10)
        
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        difficulty = "intermediate"
                                        exerciseSuggestion.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image(systemName: "staroflife.circle")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("Intermediate")
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
                                .padding(10)
        
                                Button {
                                    //Execute Action
                                    withAnimation {
                                        difficulty = "expert"
                                        exerciseSuggestion.toggle()
                                    }
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                } label: {
                                    HStack {
                                        Image(systemName: "staroflife.circle")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("Expert")
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
                                .padding(10)
                                
                                Spacer()
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

//#Preview {
//    ExerciseDifficultyView()
//}
