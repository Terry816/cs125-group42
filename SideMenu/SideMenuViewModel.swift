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
    case ZotWater
    case ZotSleep
    case ZotFit
    case Score
    
    var title : String {
        switch self {
        case .Home: return "Home"
        case .ZotWater: return "ZotWater"
        case .ZotSleep: return "ZotSleep"
        case .ZotFit: return "ZotFit"
        case .Score: return "Score"
        
        }
    }
    var imageName: String {
        switch self {
        case .Home: return "house.circle"
        case .ZotWater: return "drop.circle"
        case .ZotSleep: return "bed.double.circle"
        case .ZotFit: return "heart.circle"
        case .Score: return "heart.circle"
            
        }
    }
    var destination: some View {
        switch self {
        case .Home: return AnyView(HomeView())
        case .ZotWater: return AnyView(HydrationView())
        case .ZotSleep: return AnyView(ZotSleepView())
        case .ZotFit: return AnyView(ZotFitView())
        case .Score: return AnyView(ScoreView())
        }
    }
}
