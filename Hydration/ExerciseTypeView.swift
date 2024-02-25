//
//  ExerciseTypeView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/24/24.
//

import SwiftUI

struct ExerciseTypeView: View {
    @State private var isSelected = false
    var body: some View {
        HStack {
            VStack
            {
                Text("Please select an option.")
                HStack {
                    Button {
                        //Execute Action
                        withAnimation {
                            isSelected.toggle()
                        }
                    } label: {
                        VStack {
                            Image("workout1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .padding(.top)
                                .padding(.leading)
                                .padding(.trailing)
                            Text("Bodybuilding")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(.black)
                                .padding(.bottom)
                        }
                    }
                    .buttonStyle(.bordered)
                    .background(isSelected ? Color.blue.opacity(0.6) : Color.clear)
                    .cornerRadius(40)
                    .overlay(
                        isSelected ?
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .padding(8)
                                .background(Color.black)
                                .clipShape(Circle())
                                .offset(x: 70, y: -70)
                            : nil
                    )
                }
            }
        }
//        .background(.blue)
    }
}

#Preview {
    ExerciseTypeView()
}
