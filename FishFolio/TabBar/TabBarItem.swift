//
//  TabBarItem.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

enum TabBarItem: Hashable {
    case catchs, new, statistics, settings
    
    var iconName: String {
        switch self {
        case .catchs: return "fish"
        case .new: return "plus.circle"
        case .statistics: return "trophy"
        case .settings: return "gear"
        }
    }
    
    var title: String {
        switch self {
        case .catchs: return "Catches"
        case .new: return "New"
        case .statistics: return "Statistics"
        case .settings: return "Settings"
        }
    }
    
    var color: Color {
        switch self {
        case .catchs: return Color.blue
        case .new: return Color.green
        case .statistics: return Color.orange
        case .settings: return Color.red
        }
    }
}
