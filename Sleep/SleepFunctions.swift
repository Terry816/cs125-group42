//
//  SleepFunctions.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/13/24.
//

import Foundation
import SwiftUI

struct TimePickerView: UIViewRepresentable {
    @Binding var selectedTime: Date

    func makeUIView(context: Context) -> UIDatePicker {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(context.coordinator, action: #selector(Coordinator.timeChanged(_:)), for: .valueChanged)
        return timePicker
    }

    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.date = selectedTime
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: TimePickerView

        init(_ parent: TimePickerView) {
            self.parent = parent
        }

        @objc func timeChanged(_ timePicker: UIDatePicker) {
            parent.selectedTime = timePicker.date
        }
    }
}


func formattedTime(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
}


func formattedSecondTime(from timeInterval: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.unitsStyle = .abbreviated

    return formatter.string(from: timeInterval) ?? ""
}


func formattedThirdTime(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter.string(from: date)
}


func extractBedtime(from sleepEntry: String) -> String {
    guard let startIndex = sleepEntry.range(of: "start: ")?.upperBound,
          let endIndex = sleepEntry.range(of: ", end:")?.lowerBound else {
        return "Unknown"
    }

    let bedtime = String(sleepEntry[startIndex..<endIndex])
    return bedtime
}

func extractWakeUpTime(from sleepEntry: String) -> String {
    guard let startIndex = sleepEntry.range(of: "end: ")?.upperBound else {
        return "Unknown"
    }

    let wakeUpTime = String(sleepEntry[startIndex...])
    return wakeUpTime
}

func formattedCurrentDay() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter.string(from: Date())
   }

func formattedCurrentDate() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d, yyyy"
    return formatter.string(from: Date())
   }


struct CircularProgressView: View {
  let progress: CGFloat

  var body: some View {
    ZStack {
      // Background for the progress bar
      Circle()
        .stroke(lineWidth: 20)
        .opacity(0.1)
        .foregroundColor(.black)

        Circle()
            .trim(from: 0.0, to: min(progress, 1.0))
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
            .foregroundColor(progress >= 0.8 ? .green : (progress >= 0.45 ? .yellow : .red))
            .rotationEffect(Angle(degrees: 270.0))
            .animation(.linear, value: progress)
        
        Text("\(Int(progress * 100))%")
            .foregroundColor(.black)
            .font(.custom("Oswald", fixedSize: 20))
    }
  }
}
