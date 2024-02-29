//  Created by Simar Cheema on 2/11/24.
//
import SwiftUI

var muscle = "biceps"
var etype = "strength"
var diff = ""

struct ZotFitView: View {
    @State var sideMenu = false
    var body: some View {
        NavigationView {
            ZStack {
                if sideMenu {
                    SideMenuView()
                }
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
                                Text("ZotFit")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .heavy))
                                Spacer()
                            }
                        }
                    }
                    //Main body of app is here:
                    VStack {
                        Spacer()
                        ExerciseTypeView()
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

func getUser() async throws -> String {
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

struct ExerciseResult: Codable{
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
}

enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}

#Preview {
    ZotFitView()
}
