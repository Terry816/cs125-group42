//
//  HydrationStatsView.swift
//  Hydration
//
//  Created by Simar Cheema on 3/11/24.
//

import SwiftUI

struct HydrationStatsView: View {
    @State var sideMenu = false
    @State var hydrationView = false
    var body: some View {
        NavigationStack {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                NavigationLink(destination: HydrationView().navigationBarBackButtonHidden(true), isActive: $hydrationView) {}
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
                                Text("ZotWater")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .heavy))
                                Spacer()
                            }
                        }
                    }
                    //Main body of app is here:
                    VStack {
                        ZStack {
                            HStack {
                                Button {
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                     generator.impactOccurred()
                                    withAnimation(.spring()) {
                                        hydrationView.toggle()
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
                                Text("Daily Water Intake")
                                    .font(.system(size: 24, weight: .bold))
                                    .padding(.top, 10)
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                        }
                        
                        VStack{
                            HStack {
                                Text("Goal for the Day:")
                                    .padding()
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                VStack{
                                    Text("168")
                                    Text("ounces")
                                }
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .padding(.trailing)
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(.white.opacity(0.2))
                            .cornerRadius(10)
                            .shadow(radius: 2)

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
                            .foregroundColor(.white)
                            .background(.white.opacity(0.2))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                        }
                        .padding(.top, 25)
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
    HydrationStatsView()
}
