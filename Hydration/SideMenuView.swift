//
//  SideMenuView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/10/24.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0, green: 0.3922, blue: 0.6431), Color.black]), startPoint: .top, endPoint: .bottom)
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
