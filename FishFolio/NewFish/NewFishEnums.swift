//
//  NewFishEnums.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import Foundation

enum WaterCondition: String, CaseIterable, Identifiable, CustomStringConvertible {
    
    case algae
    case clear
    case muddy
    case murky
    case polluted
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .algae: return "Algae"
        case .clear: return "Clear"
        case .muddy: return "Muddy"
        case .murky: return "Murky"
        case .polluted: return "Polluted"
        }
    }
}
