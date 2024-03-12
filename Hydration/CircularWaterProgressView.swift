//
//  CircularWaterProgressView.swift
//  Hydration
//
//  Created by Simar Cheema on 3/12/24.
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
            .foregroundColor(.white)

    }
  }
}

#Preview {
    CircularWaterProgressView(progress: 1)
}
