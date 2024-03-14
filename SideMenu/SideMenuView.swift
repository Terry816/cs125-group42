//
//  SideMenuView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/10/24.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0, blue: 0), Color(red: 0.25, green: 0.30, blue: 0.59)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                // Header
                SideMenuHeaderView()
                    .frame(height: 140)
                // Cell items
                ForEach(SideMenuViewModel.allCases, id: \.self) { option in
                    NavigationLink(destination: option.destination.navigationBarBackButtonHidden(true), label: {
                        SideMenuOptionView(viewModel: option)
                    })
                }
                Spacer()
            }
            
        }
    }
}

#Preview {
    SideMenuView()
}
