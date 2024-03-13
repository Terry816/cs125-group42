//
//  SideMenuHeader.swift
//  Hydration
//
//  Created by Simar Cheema on 2/10/24.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        
        HStack {
            VStack(alignment: .leading, content: {
                Text("Zot Health")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
            })
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SideMenuHeaderView()
}
