//
//  SettingsView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var weightUnits: WeightUnits = .pounds
    @State private var lengthUnits: LengthUnits = .inches
    @State private var temperatureUnits: TemperatureUnits = .fahrenheit
    
    @State private var isShowing = false
    
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
                    Picker("Temperature", selection: $temperatureUnits) {
                        ForEach(TemperatureUnits.allCases) { temperature in
                            Text(temperature.description)
                        }
                    }
                }
                
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("Beta 1.0")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("VStudios")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section {
                    Button("Delete All Data", role: .destructive) {  isShowing = true }
                }
                
            }
            .navigationTitle("Settings")
            .alert("Delete All Data?", isPresented: $isShowing) {
                Button("Delete", role: .destructive) {}
            } message: {
                Text("You cannont undo this action")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
