//
//  ExerciseTypeView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/24/24.
// 

import SwiftUI
import HealthKit

struct ExerciseTypeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var muscleView = false
    @State var exercise: String = ""
    
    var body: some View {
            NavigationLink(destination: MuscleGroupView(type: $exercise).navigationBarBackButtonHidden(true), isActive: $muscleView) {}
            VStack
            {
                Text("Please select exercise type")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack {
                    //Bodybuilding button
                    Button {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                         generator.impactOccurred()
                        //Execute Action
                        withAnimation {
                            exercise = "strength"
                            muscleView.toggle()
                        }
                    } label: {
                        HStack {
                            Image("workout3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .padding(.top)
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom)
                                .background(.white)
                                .cornerRadius(40)
                            Spacer()
                            Text("Bodybuilding")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
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
                
                    
                    //Warmup button
                    Button {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                         generator.impactOccurred()
                        //Execute Action
                        withAnimation {
                            exercise = "stretching"
                            muscleView.toggle()
                        }
                    } label: {
                        HStack {
                            Image("workout4")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .padding(.top)
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom)
                                .background(.white)
                                .cornerRadius(40)
                            Spacer()
                            Text("Warmup")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
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
                    
                    //Cardio button
                    Button {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                         generator.impactOccurred()
                        //Execute Action
                        withAnimation {
                            exercise = "cardio"
                            muscleView.toggle()
                        }
                    } label: {
                        HStack {
                            Image("workout6")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .padding(.top)
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom)
                                .background(.white)
                                .cornerRadius(40)
                            Spacer()
                            Text("Cardio")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.white)
                            Spacer()
                            Image(systemName: "chevron.right")
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
            }
        }
}

#Preview {
    ExerciseTypeView().environmentObject(AuthViewModel())
}
