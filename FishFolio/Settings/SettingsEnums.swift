//
//  SettingsEnums.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import Foundation

enum WeightUnits: CaseIterable, Identifiable, CustomStringConvertible {
    
    case pounds
    case kilograms
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .pounds: return "Pounds"
        case .kilograms: return "Kilograms"
        }
    }
}

enum LengthUnits: CaseIterable, Identifiable, CustomStringConvertible {
    
    case inches
    case centimeters
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .inches: return "Inches"
        case .centimeters: return "Centimeters"
        }
    }
}

enum TemperatureUnits: CaseIterable, Identifiable, CustomStringConvertible {
    
    case fahrenheit
    case celsius
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .fahrenheit: return "Fahrenheit"
        case .celsius: return "Celsius"
        }
    }
}
