//
//  SideMenuViewModel.swift
//  Hydration
//
//  Created by Simar Cheema on 2/10/24.
//

import Foundation
import SwiftUI

enum SideMenuViewModel: Int, CaseIterable {
    case Home
    case Water
    case Sleep
    case Fitness
    case Score
    
    var title : String {
        switch self {
        case .Home: return "Home"
        case .Water: return "Water"
        case .Sleep: return "Sleep"
        case .Fitness: return "Fitness"
        case .Score: return "Score"
        
        }
    }
    var imageName: String {
        switch self {
        case .Home: return "house.circle"
        case .Water: return "drop.circle"
        case .Sleep: return "bed.double.circle"
        case .Fitness: return "figure.run.circle"
        case .Score: return "heart.circle"
            
        }
    }
    var destination: some View {
        switch self {
        case .Home: return AnyView(HomeView())
        case .Water: return AnyView(HydrationView())
        case .Sleep: return AnyView(ZotSleepView())
        case .Fitness: return AnyView(ZotFitView())
        case .Score: return AnyView(ScoreView())
        }
    }
}
