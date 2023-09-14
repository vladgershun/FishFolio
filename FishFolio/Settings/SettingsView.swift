//
//  SettingsView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("weightUnits") private var weightUnits: WeightUnits = .pounds
    @AppStorage("lengthUnits") private var lengthUnits: LengthUnits = .inches
    @AppStorage("temperatureUnits") private var temperatureUnits: TemperatureUnits = .fahrenheit
    
    @State private var speciesPresented = false
    @State private var baitPresented = false
    @State private var allPresented = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                Form {
                    Section("App Info") {
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
                    
                    Section("Units") {
                        Picker("Weight", selection: $weightUnits) {
                            ForEach(WeightUnits.allCases) { weight in
                                Text(weight.description)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Picker("Length", selection: $lengthUnits) {
                            ForEach(LengthUnits.allCases) { length in
                                Text(length.description)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        
                        Picker("Temperature", selection: $temperatureUnits) {
                            ForEach(TemperatureUnits.allCases) { temperature in
                                Text(temperature.description)
                            }
                        }
                        
                        .pickerStyle(.menu)
                    }
                    .tint(.secondary)
                    
                    Section {
                        Button("Delete Species Data", role: .destructive) { speciesPresented = true }
                        Button("Delete Bait Data", role: .destructive) { baitPresented = true }
                    }
                    
                    Section {
                        Button("Delete All Data", role: .destructive) { allPresented = true }
                    }
                }
                .navigationTitle("Settings")
                .confirmationDialog("Delete All Species?", isPresented: $speciesPresented) {
                    Button("Delete", role: .destructive) { }
                } message: {
                    Text("This will delete all user generated species")
                }
                .confirmationDialog("Delete All Bait?", isPresented: $baitPresented) {
                    Button("Delete", role: .destructive) { }
                } message: {
                    Text("This will delete all user generated bait")
                }
                .confirmationDialog("Delete All Data?", isPresented: $allPresented) {
                    Button("Delete", role: .destructive) { }
                } message: {
                    Text("You cannont undo this action")
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
    }
}
