//
//  SleepResultView.swift
//  Hydration
//
//  Created by Philip Nguyen on 2/24/24.
//

import Foundation
import SwiftUI

//
//  ContentView.swift
//  HealthSleep
//
//  Created by Philip Nguyen on 2/24/24.
//

import HealthKit


struct HealthKitView: View {
    @State private var isAuthorized = false
    var healthStore: HKHealthStore = HKHealthStore()

    var body: some View {
        VStack {
            if isAuthorized {
                Text("HealthKit Authorization Successful")
                    .padding()
            } else {
                Text("Please authorize HealthKit")
                    .padding()
                    .onAppear {
                        requestAuthorization()
                    }
            }
        }
    }

    private func requestAuthorization() {
        let healthStore = HKHealthStore()
        
        // Request authorization to access sleep data
        let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { (success, error) in
            if success {
                // Query for sleep data
                let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 30, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                    guard let samples = samples as? [HKCategorySample], error == nil else {
                        print("Failed to fetch sleep data: \(error!.localizedDescription)")
                        return
                    }
                    for sample in samples {
                        let startDate = sample.startDate
                        let endDate = sample.endDate
                        print("Sleep start: \(startDate), end: \(endDate)")
                    }
                }
                healthStore.execute(query)
            } else {
                print("Authorization to access sleep data was denied.")
            }
        }
    }
}

struct HealthKitView_Previews: PreviewProvider {
    static var previews: some View {
        HealthKitView()
    }
}
