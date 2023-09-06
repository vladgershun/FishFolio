//
//  NewFishView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct NewFishView: View {
    
    @FocusState var isInputActive: Bool
    
    @State private var species: String = ""
    
    private var length: Double? {
        if let lengthWhole {
            return Double(lengthWhole) + (Double(lengthDecimal ?? 0) * 0.1)
        }
        if let lengthDecimal {
            return Double(lengthWhole ?? 0) + (Double(lengthDecimal) * 0.1)
        }
        return nil
    }
    
    @State private var lengthWhole: Int?
    @State private var lengthDecimal: Int?
    
    @State private var weightWhole: Int?
    @State private var weightDecimal: Int?
    
    private var weight: Double? {
        if let weightWhole {
            return Double(weightWhole) + (Double(weightDecimal ?? 0) * 0.1)
        }
        if let weightDecimal {
            return Double(weightWhole ?? 0) + (Double(weightDecimal) * 0.1)
        }
        return nil
    }
    
    @State private var bait: String = ""
    @State private var waterCondition: WaterCondition?
    @State private var waterTemperature: Int?
    @State private var locationName: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Fish") {
                    
                    NavigationLink {
                        SpeciesSubView(species: $species)
                    } label: {
                        HStack {
                            Text("Species")
                            Spacer()
                            Text(species)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink {
                        BaitSubView(bait: $bait)
                    } label: {
                        HStack {
                            Text("Bait")
                            Spacer()
                            Text(bait)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink {
                        LengthSubView(lengthWhole: $lengthWhole, lengthDecimal: $lengthDecimal)
                    } label: {
                        HStack {
                            Text("Length")
                            Spacer()
                            if let length {
                                Text("^[\(length, specifier: "%.1f") \("inch")](inflect: true)")
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                    }
                    
                    NavigationLink {
                        WeightSubView(weightWhole: $weightWhole, weightDecimal: $weightDecimal)
                    } label: {
                        HStack {
                            Text("Weight")
                            Spacer()
                            if let weight {
                                Text("^[\(weight, specifier: "%.1f") \("pound")](inflect: true)")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                Section("Location") {
                    TextField("Name", text: $locationName)
                        .focused($isInputActive)
                    
                    NavigationLink {
                        TemperatureSubView(waterTemperature: $waterTemperature)
                    } label: {
                        HStack {
                            Text("Water Temperature")
                            Spacer()
                            if let waterTemperature {
                                Text("\(waterTemperature)°F")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Picker("Water Condition", selection: $waterCondition) {
                        ForEach(WaterCondition.allCases) { waterCondition in
                            Text(waterCondition.description)
                                .tag(waterCondition as WaterCondition?)
                        }
                    }
                    .tint(.secondary)
                    .pickerStyle(.navigationLink)
                    .focused($isInputActive)
                }
                
                Button {
                    // Add later
                } label: {
                    HStack {
                        Image(systemName: "camera")
                        Text("Add Image")
                    }
                    
                }
            }
            .navigationTitle("New Fish")
        }
    }
}

struct NewFishView_Previews: PreviewProvider {
    static var previews: some View {
        NewFishView()
    }
}



