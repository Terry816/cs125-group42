//
//  HydrationStatsView.swift
//  Hydration
//
//  Created by Simar Cheema on 3/11/24.
//

import SwiftUI

struct CircularWaterProgressView: View {
  let progress: CGFloat

  var body: some View {
    ZStack {
      // Background for the progress bar
      Circle()
        .stroke(lineWidth: 20)
        .opacity(0.1)
        .foregroundColor(.blue)

      // Foreground or the actual progress bar
      Circle()
        .trim(from: 0.0, to: min(progress, 1.0))
        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
        .foregroundColor(.blue)
        .rotationEffect(Angle(degrees: 270.0))
        .animation(.linear, value: progress)
        
        Text("\(Int(progress * 100))%")
            .foregroundColor(.black)

    }
  }
}


struct HydrationStatsView: View {
    var body: some View {
        
        VStack{
            
            HStack {
                Text("Goal for the Day")
                    .padding()
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .font(.system(size: 16, weight: .bold, design: .rounded))

                VStack{
                    Text("168")
                    Text("ounces")
                      
                }
                .font(.system(size: 24, weight: .bold, design: .rounded))
            }
            .font(.headline)
            .foregroundColor(.black)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 2)
            .frame(width: 200, height: 300)

            
            
            VStack{
                Text("Water Progress")
                    .padding()
                    .padding(.bottom, 10)
                    .font(.system(size: 16, weight: .bold, design: .rounded))


                CircularWaterProgressView(progress: 1)
                    .frame(width: 115, height: 105)
                    .padding(.top, 13)
                    .padding(.bottom, 30)
            }
            .font(.headline)
            .foregroundColor(.black)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 2)

            
        }
        .padding(.top, 25)
        Spacer()
        


        
    }
}


#Preview {
    HydrationStatsView()
}
