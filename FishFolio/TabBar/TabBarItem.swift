//
//  TabBarItem.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

enum TabBarItem: Hashable {
    
    case fish, new, statistics, settings
    
    var iconName: String {
        switch self {
        case .fish: return "fish"
        case .new: return "plus.circle"
        case .statistics: return "trophy"
        case .settings: return "gear"
        }
    }
    
    var title: String {
        switch self {
        case .fish: return "Fish"
        case .new: return "New"
        case .statistics: return "Statistics"
        case .settings: return "Settings"
        }
    }
}
