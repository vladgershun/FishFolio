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
    @State private var length: Int?
    @State private var weight: Double?
    @State private var bait: String = ""
    @State private var waterCondition: WaterCondition?
    @State private var waterTemperature: Int?
    @State private var locationName: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Fish") {
                    TextField("Species", text: $species)
                        .focused($isInputActive)
                    TextField("Bait", text: $bait)
                        .focused($isInputActive)
                    
                    
//                    NavigationLink {
//                        TestView(bait: $bait)
//                    } label: {
//                        HStack {
//                            Text("Bait")
//                            Spacer()
//                            Text("item")
//                                .foregroundColor(.secondary)
//                        }
//
//                    }
                    
                    
                    
                    Picker("Length", selection: $length) {
                        ForEach(1..<100, id: \.self) { length in
                            Text("^[\(length) \("inch")](inflect: true)")
                                .tag(length as Int?)
                        }
                    }
                    .tint(.secondary)
                    .pickerStyle(.navigationLink)
                    .focused($isInputActive)
                    
                    Picker("Weight", selection: $weight) {
                        ForEach(Array(stride(from: 1, through: 100, by: 0.1)), id: \.self) { weight in
                            Text("^[\(weight, specifier: "%.1f") \("pound")](inflect: true)")
                                .tag(weight as Double?)
                        }
                    }
                    .tint(.secondary)
                    .pickerStyle(.navigationLink)
                    .focused($isInputActive)
                }
                
                Section("Location") {
                    TextField("Name", text: $locationName)
                        .focused($isInputActive)
                    
                    Picker("Water Temperature", selection: $waterTemperature) {
                        ForEach(32..<100, id: \.self) { waterTemperature in
                            Text("\(waterTemperature) °F")
                                .tag(waterTemperature as Int?)
                        }
                    }
                    .tint(.secondary)
                    .pickerStyle(.navigationLink)
                    .focused($isInputActive)
                    
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

struct TestView: View {
    
    @Binding var bait: String?
    @State private var baitList: [String] = Array(repeating: "Bait", count: 1)
    
    var body: some View {
        
        List(selection: $bait) {
            Picker("Select Bait", selection: $bait) {
                ForEach(baitList, id: \.self) { selected in
                    Text(selected)
                        .onTapGesture {
                            bait = selected
                        }
                }
            }
            .pickerStyle(.inline)
            
        }
    }
}

