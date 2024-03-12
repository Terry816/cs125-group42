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
    @State var exercises: [Exercise] = []
    
    var body: some View {
        NavigationStack {
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
                                        let generator = UIImpactFeedbackGenerator(style: .medium)
                                         generator.impactOccurred()
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
                                        ForEach(exercises, id: \.name) { exercise in
                                                VStack(alignment: .leading, spacing: 8) {
                                                    Text(exercise.name)
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)

                                                    Text("Type: \(exercise.type.capitalized)")
                                                        .font(.headline)
                                                        .foregroundColor(.white)

                                                    Text("Difficulty: \(exercise.difficulty.capitalized)")
                                                        .font(.headline)
                                                        .foregroundColor(.white)

                                                    Text("Muscle: \(exercise.muscle.capitalized)")
                                                        .font(.subheadline)
                                                        .foregroundColor(.white)

                                                    Text("Equipment: \(exercise.equipment.capitalized)")
                                                        .font(.subheadline)
                                                        .foregroundColor(.white)

                                                    Text("Instructions: \(exercise.instructions)")
                                                        .font(.body)
                                                        .foregroundColor(.white)
                                                        .padding(.top, 4)

                                                    Divider()
                                                        .background(Color.white)
                                                        .padding(.vertical, 8)
                                                }
                                                .padding()
                                                .background(Color.white.opacity(0.1))
                                                .cornerRadius(8)
                                            }
                                    }
                                    Spacer()
                                }
                                .padding()
                            }
                            Spacer()
                        }
                        .task {
                            do{
                                exercises = try await getUser(muscle: muscle, etype: type, diff: difficulty)
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

func getUser(muscle: String, etype: String, diff: String) async throws -> [Exercise] {
    var difficulty = diff
    var muscle_type = muscle
    if etype == "cardio" {
        difficulty = ""
        muscle_type = ""
    }
    let endpoint = "https://api.api-ninjas.com/v1/exercises?muscle=\(muscle_type)&type=\(etype)&difficulty=\(difficulty)"
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
        let decoder = JSONDecoder()
        let exercises = try decoder.decode([Exercise].self, from: data)
        // Now `exercises` is an array of `Exercise` structs, you can access each exercise's attributes
        return exercises
    } catch {
        print(error)
        // Handle or throw the error
    }
//    do {
//        if let dataString = String(data: data, encoding: .utf8) {
//            print(dataString)
//            return dataString
//        } else {
//            print("Unable to convert data to string")
//        }
//    }
    return []
}


enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}

struct Exercise: Decodable {
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
}


struct ExerciseSuggestionView_Preview: PreviewProvider {
  @State static var type = ""
  @State static var muscle = ""
  @State static var difficulty = ""
  static var previews: some View {
      ExerciseSuggestionView(type: $type, muscle: $muscle, difficulty: $difficulty)
  }
}
