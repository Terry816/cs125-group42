//
//  SideMenuOptionView.swift
//  Hydration
//
//  Created by Simar Cheema on 2/10/24.
//

import SwiftUI

struct SideMenuOptionView: View {
    let viewModel: SideMenuViewModel
    var body: some View {
        HStack(spacing: 12, content: {
            Image(systemName: viewModel.imageName)
                .resizable()
                .frame(width: 26, height: 26)
            Text(viewModel.title)
                .font(.system(size: 22, weight: .semibold))
            
            Spacer()
        })
        .foregroundColor(.white)
        .padding()
    }
}

#Preview {
    SideMenuOptionView(viewModel: .Water)
}
