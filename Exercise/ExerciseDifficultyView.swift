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
        NavigationStack {
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
                            Text("Fitness")
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
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                         generator.impactOccurred()
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
                                        Image(systemName: "1.circle.fill")
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
                                .background(Color.black.opacity(0.7))
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
                                        Image(systemName: "2.circle.fill")
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
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(40)
                                .padding(10)
        
                                
                                Spacer()
                            }
                            .padding(.top, 20)
                        }
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

struct ExerciseDifficulty_Preview: PreviewProvider {
    @State static var type = ""
    @State static var muscle = ""
    static var previews: some View {
        ExerciseDifficultyView(type: $type, muscle: $muscle)
    }
}
