//
//  ExerciseSuggestionView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/29/24.
//

import SwiftUI

struct ExerciseSuggestionView: View {
    @Binding var type: String
    @Binding var muscle: String
    @Binding var difficulty: String
    @State var sideMenu = false
    @State var exerciseDifficulty = false
    @State var loaded = false
    @State var user = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
                
                NavigationLink(destination: ExerciseDifficultyView(type: $type, muscle: $muscle).navigationBarBackButtonHidden(true), isActive: $exerciseDifficulty) {}
                VStack {
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
                            Text("ZotFit")
                                .foregroundColor(.white)
                                .font(.system(size: 30, weight: .heavy))
                            Spacer()
                        }
                    }
                    Spacer()
                    //Main body of app is here:
                    VStack {
                        Spacer()
                        VStack
                        {
                            VStack {
                                HStack {
                                    Button {
                                        withAnimation(.spring()) {
                                            exerciseDifficulty.toggle()
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
                                ScrollView {
                                    Spacer()
                                    if loaded {
                                        Text(user)
                                            .font(.system(size: 24, weight: .bold))
                                            .padding(.top, 10)
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                            Spacer()
                        }
                        .task {
                            do{
                                user = try await getUser(muscle: muscle, etype: type, diff: difficulty)
                                loaded.toggle()
                                
                            } catch GHError.invalidURL {
                                print("invalid URL")
                            } catch GHError.invalidResponse{
                                print("invalid Response")
                            } catch GHError.invalidData{
                                print("invalid Data")
                            } catch {
                                print("unexpected error")
                            }
                        }
                        Spacer()
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0.81), Color(red: 0, green: 0, blue: 0.5)]), startPoint: .top, endPoint: .bottom))
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

func getUser(muscle: String, etype: String, diff: String) async throws -> String {
    let endpoint = "https://api.api-ninjas.com/v1/exercises?muscle=\(muscle)&type=\(etype)&difficulty=\(diff)"
    guard let url = URL(string: endpoint) else {
        throw GHError.invalidURL
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.setValue("5SAcm6jn9u26Pkuk4iIu3Q==oZLXyNGrMRXxKjQx", forHTTPHeaderField: "X-Api-Key")
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    do {
        if let dataString = String(data: data, encoding: .utf8) {
            return dataString
        } else {
            print("Unable to convert data to string")
        }
    }
    return ""
}


enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}


struct ExerciseSuggestionView_Preview: PreviewProvider {
  @State static var type = ""
  @State static var muscle = ""
  @State static var difficulty = ""
  static var previews: some View {
      ExerciseSuggestionView(type: $type, muscle: $muscle, difficulty: $difficulty)
  }
}
