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
    @State private var locationPresented = false
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
                        VStack {
                            HStack {
                                Text("Weight")
                                Spacer()
                                Picker("Weight", selection: $weightUnits) {
                                    ForEach(WeightUnits.allCases) { weight in
                                        Text(weight.description)
                                    }
                                }
                                .padding(.vertical, 5)
                                .frame(maxWidth: geo.size.width / 2)
                                .pickerStyle(.segmented)
                            }
                            
                            HStack {
                                Text("Length")
                                Spacer()
                                Picker("Length", selection: $lengthUnits) {
                                    ForEach(LengthUnits.allCases) { length in
                                        Text(length.description)
                                    }
                                }
                                .padding(.vertical, 5)
                                .frame(maxWidth: geo.size.width / 2)
                                .pickerStyle(.segmented)
                            }
                            
                            HStack {
                                Text("Temperature")
                                Spacer()
                                Picker("Temperature", selection: $temperatureUnits) {
                                    ForEach(TemperatureUnits.allCases) { temperature in
                                        Text(temperature.description)
                                    }
                                }
                                .padding(.vertical, 5)
                                .frame(maxWidth: geo.size.width / 2)
                                .pickerStyle(.segmented)
                            }
                        }
                        
                    }
                    
                    Section {
                        Button("Delete Species Data", role: .destructive) { speciesPresented = true }
                        Button("Delete Bait Data", role: .destructive) { baitPresented = true }
                        Button("Delete Location Data", role: .destructive) { locationPresented = true }
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
                .confirmationDialog("Delete All Locations?", isPresented: $locationPresented) {
                    Button("Delete", role: .destructive) { }
                } message: {
                    Text("This will delete all user generated locations")
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
