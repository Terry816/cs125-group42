//
//  StepsView.swift
//  Hydration
//
//  Created by Simar Cheema on 3/14/24.
//

import SwiftUI
import HealthKit

struct StepsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var sideMenu = false
    @State var fitView = false
    @State private var steps_day = 0.0
    @State private var steps_week = 0.0
    @State private var goal = 10000.0
    @State private var isAuthorized = false
    
    private func requestAuthorization() {
        let user = viewModel.currentUser
        if let weightInPounds = user?.weight, let heightInCm = user?.height, let age = user?.age {
            let weightInKg: Double = Double(weightInPounds) * 0.453592
            let heightInMeters: Double = Double(heightInCm) / 100.0
            // Now you can use weightInKg and heightInMeters for further calculations
            let bmi = weightInKg / pow(heightInMeters, 2)
            let baselineSteps: Double = 10000
            if bmi < 18.5 {
                goal = baselineSteps * 0.9
            } else if bmi <= 24.9 {
                goal = baselineSteps // No change needed
            } else if bmi <= 29.9 {
                goal = baselineSteps * 1.1
            } else {
                goal = baselineSteps * 1.2
            }
            if age < 20 {
                goal *= 1.1
            } else if age > 50 {
                goal *= 0.9
            }
            
            print("goalllll:", goal)
        } else {
            // Handle the case where user, weight, or height might be nil
        }
        
        
        let healthStore = HKHealthStore()
        let typesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!, HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: .heartRate)!]
        let typesToWrite: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!, HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!]
        healthStore.requestAuthorization(toShare: typesToWrite, read: typesToRead) { (success, error) in
            if success {
                var stepsCount = HKQuantityType.quantityType(forIdentifier: .stepCount)!
                var startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
                var predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
                
                var query = HKSampleQuery(sampleType: stepsCount, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { (query, results, error) in
                    guard let samples = results as? [HKQuantitySample] else {
                        return
                    }

                    let totalSteps = samples.reduce(0, {$0 + $1.quantity.doubleValue(for: HKUnit.count())})
                    steps_week = totalSteps
                    
                    if steps_week >= goal{
                        DataModel.fitPercent = 100
                        print("Steps for WEEK:", steps_week)
                        print("GOAL:", goal)
                        print("GOOD")
                    }
                    else{
                        let transferStep = Double(steps_week) / Double(goal)
                        DataModel.fitPercent = Int(transferStep * 100)
                        print("LESS THAN GOAL:", Int(transferStep))
                        print("BAD")
                    }
                    
                }
                healthStore.execute(query)
                
                stepsCount = HKQuantityType.quantityType(forIdentifier: .stepCount)!
                startDate = Calendar.current.startOfDay(for: Date())
                predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
                
                query = HKSampleQuery(sampleType: stepsCount, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { (query, results, error) in
                    guard let samples = results as? [HKQuantitySample] else {
                        return
                    }

                    let totalSteps = samples.reduce(0, {$0 + $1.quantity.doubleValue(for: HKUnit.count())})
                    steps_day = totalSteps
                    print("Steps for the day:", steps_day)
                    
                    
                    
                }
                healthStore.execute(query)
                
            } else {
                print("Authorization to access sleep data was denied.")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: ZotFitView().navigationBarBackButtonHidden(true), isActive: $fitView) {}
                //--------------------------------------------------------
                // HealthKit Authorization
                VStack {
                    if isAuthorized == false {
                        Text("Please authorize HealthKit")
                            .padding()
                            .onAppear {
                                requestAuthorization()
                                isAuthorized = true
                            }
                    }
                }
                //--------------------------------------------------------
                VStack {
                    HStack(alignment: .center) {
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
                    }
                    ZStack {
                        HStack {
                            Button {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                 generator.impactOccurred()
                                withAnimation(.spring()) {
                                    fitView.toggle()
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
                            Text("Steps Dashboard")
                                .font(.system(size: 24, weight: .bold))
                                .padding(.top, 10)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                    }
                    //Main body of app is here:
                    VStack {
                        HStack(spacing: 0) {
                            HStack{
                                Text("\(Int(steps_day))")
                                   .font(.system(size: 40, weight: .bold, design: .rounded))
                                   .padding(.top, 10)
                                   .padding(.bottom, 10)
                                   .foregroundColor(Color.red)

                               VStack{
                                   Text("Today")
                                       .font(.system(size: 16, weight: .bold, design: .rounded))
                                       .padding(.bottom, -15)
                                   
                                   Text("Steps")
                                       .font(.system(size: 30, weight: .bold, design: .rounded))
                                       .foregroundColor(Color.red)
                               }
                               .padding(.vertical)
                           }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.2))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(30)
                        .padding()
                        HStack(spacing: 0) {
                            HStack{
                               Text("\(Int(goal))")
                                    .font(.system(size: 40, weight: .bold, design: .rounded))
                                    .padding(.top, 10)
                                    .padding(.bottom, 10)
                                    .foregroundColor(Color.green)

                               VStack{
                                   Text("Your Goal")
                                       .font(.system(size: 16, weight: .bold, design: .rounded))
                                       .padding(.bottom, -15)
                                       .foregroundColor(.white)
                                   
                                   Text("Steps")
                                       .font(.system(size: 30, weight: .bold, design: .rounded))
                                       .foregroundColor(Color.green)
                               }
                               .padding(.vertical)
                           }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.white.opacity(0.2))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(30)
                        .padding()
                        HStack(spacing: 0) {
                            HStack{
                               Text("\(Int(steps_week/7))")
                                    .font(.system(size: 40, weight: .bold, design: .rounded))
                                    .padding(.top, 10)
                                    .padding(.bottom, 10)
                                    .foregroundColor(Color.orange)

                               VStack{
                                   Text("Weekly Average")
                                       .font(.system(size: 16, weight: .bold, design: .rounded))
                                       .padding(.bottom, -15)
                                       .foregroundColor(.white)
                                   
                                   Text("Steps")
                                       .font(.system(size: 30, weight: .bold, design: .rounded))
                                       .foregroundColor(Color.orange)
                               }
                               .padding(.vertical)
                           }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.white.opacity(0.2))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(30)
                        .padding()
                        Spacer()
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

#Preview {
    StepsView().environmentObject(AuthViewModel())
}
