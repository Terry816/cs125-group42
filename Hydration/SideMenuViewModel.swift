//
//  SideMenuViewModel.swift
//  Hydration
//
//  Created by Simar Cheema on 2/10/24.
//

import Foundation
import SwiftUI

enum SideMenuViewModel: Int, CaseIterable {
    case ZotWater
    case ZotSleep
    case ZotMeditation
    
    var title : String {
        switch self {
        case .ZotWater: return "ZotWater"
        case .ZotSleep: return "ZotSleep"
        case .ZotMeditation: return "ZotMeditation"
        }
    }
    var imageName: String {
        switch self {
        case .ZotWater: return "drop.circle"
        case .ZotSleep: return "bed.double.circle"
        case .ZotMeditation: return "heart.circle"
        }
    }
    var destination: some View {
        switch self {
        case .ZotWater: return AnyView(ContentView())
        case .ZotSleep: return AnyView(ZotSleepView())
        case .ZotMeditation: return AnyView(ZotMeditationView())
        }
    }
}
