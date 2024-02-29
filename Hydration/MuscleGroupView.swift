//
//  MuscleGroupView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/26/24.
//

import SwiftUI

struct MuscleGroupView: View {
    @State var muscle: String = ""
    
    var body: some View {
        
        VStack
        {
            Text("Please select exercise type")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 10)
                .foregroundStyle(.black)
                
            Spacer()
            Button {
                //Execute Action
                withAnimation {
                    muscle = "abs"
                }
                let generator = UIImpactFeedbackGenerator(style: .medium)
                 generator.impactOccurred()
            } label: {
                HStack {
                    Image("abs")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
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
            .background(.black)
            .cornerRadius(40)
            .padding(5)
            
            Spacer()
            
            Button {
                //Execute Action
                withAnimation {
                    muscle = "abs"
                }
                let generator = UIImpactFeedbackGenerator(style: .medium)
                 generator.impactOccurred()
            } label: {
                HStack {
                    Image("abs")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
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
            .background(.black)
            .cornerRadius(40)
            .padding(5)
            
            Spacer()
            
            Button {
                //Execute Action
                withAnimation {
                    muscle = "abs"
                }
                let generator = UIImpactFeedbackGenerator(style: .medium)
                 generator.impactOccurred()
            } label: {
                HStack {
                    Image("abs")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
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
            .background(.black)
            .cornerRadius(40)
            .padding(5)
            
            Spacer()
            
            Button {
                //Execute Action
                withAnimation {
                    muscle = "abs"
                }
                let generator = UIImpactFeedbackGenerator(style: .medium)
                 generator.impactOccurred()
            } label: {
                HStack {
                    Image("abs")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
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
            .background(.black)
            .cornerRadius(40)
            .padding(5)
            
            Spacer()
            
            Button {
                //Execute Action
                withAnimation {
                    muscle = "abs"
                }
                let generator = UIImpactFeedbackGenerator(style: .medium)
                 generator.impactOccurred()
            } label: {
                HStack {
                    Image("abs")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
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
            .background(.black)
            .cornerRadius(40)
            .padding(5)
            
            Spacer()
            
            Button {
                //Execute Action
                withAnimation {
                    muscle = "abs"
                }
                let generator = UIImpactFeedbackGenerator(style: .medium)
                 generator.impactOccurred()
            } label: {
                HStack {
                    Image("abs")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
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
            .background(.black)
            .cornerRadius(40)
            .padding(5)
            
            Spacer()
            
            Button {
                //Execute Action
                withAnimation {
                    muscle = "abs"
                }
                let generator = UIImpactFeedbackGenerator(style: .medium)
                 generator.impactOccurred()
            } label: {
                HStack {
                    Image("abs")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
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
            .background(.black)
            .cornerRadius(40)
            .padding(5)
        }
    }
}

#Preview {
    MuscleGroupView()
}
