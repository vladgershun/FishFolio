//
//  SettingsView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

enum WeightUnits: CaseIterable, Identifiable, CustomStringConvertible {
    case pounds
    case kilograms
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .pounds:
            return "Pounds"
        case .kilograms:
            return "Kilograms"
        }
    }
}

enum LengthUnits: CaseIterable, Identifiable, CustomStringConvertible {
    case inches
    case centimeters
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .inches:
            return "Inches"
        case .centimeters:
            return "Centimeters"
        }
    }
}


struct SettingsView: View {
    @State private var weightUnits: WeightUnits = .pounds
    @State private var lengthUnits: LengthUnits = .inches
    
    var body: some View {
        NavigationView {
            Form {
                Section("Units") {
                    Picker("Weight", selection: $weightUnits) {
                        ForEach(WeightUnits.allCases) { weight in
                            Text(weight.description)
                        }
                    }
                    Picker("Length", selection: $lengthUnits) {
                        ForEach(LengthUnits.allCases) { length in
                            Text(length.description)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
