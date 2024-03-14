//  Created by Simar Cheema on 2/11/24.
//
import SwiftUI
import HealthKit


var muscle = "biceps"
var etype = "strength"
var diff = ""

struct ZotFitView: View {
    
    @State var sideMenu = false
    @State private var isAuthorized = false
    
    private func requestAuthorization() {
        
        let healthStore = HKHealthStore()

           
        let typesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!, HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!, HKObjectType.quantityType(forIdentifier: .heartRate)!]

        let typesToWrite: Set<HKSampleType> = [HKObjectType.quantityType(forIdentifier: .stepCount)!, HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!]

        healthStore.requestAuthorization(toShare: typesToWrite, read: typesToRead) { (success, error) in
            if success {
               // Success
                let stepsCount = HKQuantityType.quantityType(forIdentifier: .stepCount)!
                let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
                let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)

                let query = HKSampleQuery(sampleType: stepsCount, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { (query, results, error) in
                    guard let samples = results as? [HKQuantitySample] else {
                        return
                    }

                    let totalSteps = samples.reduce(0, {$0 + $1.quantity.doubleValue(for: HKUnit.count())})
                    print("Last 7 days step count: \(totalSteps)")
                }
                healthStore.execute(query)
            } else {
                // Error handle
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
                    //Main body of app is here:
                    VStack {
                        ExerciseTypeView()
                        Spacer()
                    }
                    
                    VStack{
                        Text("PPP")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .heavy))
                    }
                }
//                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0.91), Color(red: 1, green: 0, blue: 0.75)]), startPoint: .top, endPoint: .bottom))
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
    ZotFitView()
}
