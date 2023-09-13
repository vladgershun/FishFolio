//
//  EditFishView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/13/23.
//

import SwiftUI
import CoreLocation


struct EditFishView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: DetailVM
    var fish: UIFish
    @FocusState var isInputActive: Bool
    @State private var lengthExpanded: Bool = false
    @State private var weightExpanded: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("Fish") {
                    speciesSection
                    baitSection
                    lengthSection
                    weightSection
                }
                
                Section("Location") {
                    locationSection
                    waterConditionSection
                }
                
                Section {
                    imageSection
                }
                
                Section {
                    createButtonSection
                }
            }
        }
        
    }
    
    private var speciesSection: some View {
        NavigationLink {
            EditSpeciesSubView(vm: vm, species: $vm.newSpecies)
                .onAppear {
                    withAnimation {
                        weightExpanded = false
                        lengthExpanded = false
                    }
                }
        } label: {
            HStack {
                Text("Species")
                Spacer()
                Text(vm.newSpecies)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var baitSection: some View {
        NavigationLink {
            EditBaitSubView(vm: vm, bait: $vm.newBait)
                .onAppear {
                    withAnimation {
                        weightExpanded = false
                        lengthExpanded = false
                    }
                }
        } label: {
            HStack {
                Text("Bait")
                Spacer()
                Text(vm.newBait)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var lengthSection: some View {
        DisclosureGroup(isExpanded: $lengthExpanded) {
            HStack(spacing: 0.0) {
                Picker("Whole", selection: $vm.newLength.whole) {
                    ForEach(0..<100, id: \.self) { whole in
                        Text(whole, format: .number)
                            .tag(whole as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: vm.newLength.whole) { newValue in
                    if newValue == 0 {
                        vm.newLength.whole = nil
                    }
                }

                Text(".")

                Picker("Decimal", selection: $vm.newLength.decimal) {
                    ForEach(0..<10, id: \.self) { decimal in
                        Text(decimal, format: .number)
                            .tag(decimal as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: vm.newLength.decimal) { newValue in
                    if newValue == 0 {
                        vm.newLength.decimal = nil
                    }
                }
            }
        } label: {
            HStack {
                LabeledContent("Length", value: vm.newLength.value, format: .measurement(width: .abbreviated))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    lengthExpanded.toggle()
                    weightExpanded = false
                }
            }
        }
        .tint(.secondary)
    }
    
    private var weightSection: some View {
        DisclosureGroup(isExpanded: $weightExpanded) {
            HStack(spacing: 0.0) {
                Picker("Whole", selection: $vm.newWeight.whole) {
                    ForEach(0..<100, id: \.self) { whole in
                        Text(whole, format: .number)
                            .tag(whole as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: vm.newWeight.whole) { newValue in
                    if newValue == 0 {
                        vm.newWeight.whole = nil
                    }
                }

                Text(".")

                Picker("Decimal", selection: $vm.newWeight.decimal) {
                    ForEach(0..<10, id: \.self) { decimal in
                        Text(decimal, format: .number)
                            .tag(decimal as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: vm.newWeight.decimal) { newValue in
                    if newValue == 0 {
                        vm.newWeight.decimal = nil
                    }
                }
            }
        } label: {
            HStack {
                LabeledContent("Weight", value: vm.newWeight.value, format: .measurement(width: .abbreviated))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    lengthExpanded = false
                    weightExpanded.toggle()
                }
            }
        }
        .tint(.secondary)
    }
    
    private var locationSection: some View {
        TextField("Name", text: $vm.newLocationName)
            .focused($isInputActive)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") { isInputActive = false }
                    }
                }
            }
            .onTapGesture {
                withAnimation {
                    weightExpanded = false
                    lengthExpanded = false
                }
            }
    }
    
    private var waterConditionSection: some View {
        Picker("Water Condition", selection: $vm.newWaterCondition) {
            Text("Select")
                .tag(nil as WaterCondition?)
            ForEach(WaterCondition.allCases) { waterCondition in
                Text(waterCondition.description)
                    .tag(waterCondition as WaterCondition?)
            }
        }
        .tint(.secondary)
        .pickerStyle(.menu)
        .onTapGesture {
            withAnimation {
                weightExpanded = false
                lengthExpanded = false
            }
        }
    }
    
    private var imageSection: some View {
        Button {
            // Add later
        } label: {
            HStack {
                Spacer()
                Image(systemName: "camera")
                Text("Add Image")
                Spacer()
            }
            
        }
        .onTapGesture {
            withAnimation {
                weightExpanded = false
                lengthExpanded = false
            }
        }
    }
    
    private var createButtonSection: some View {
        Button {
            isInputActive = false
            lengthExpanded = false
            weightExpanded = false
        } label: {
            HStack {
                Spacer()
                Text("Save")
                Spacer()
            }
        }
    }
    
}

struct EditFishView_Previews: PreviewProvider {
    static var previews: some View {
        EditFishView(vm: DetailVM(), fish: UIFish(id: UUID(),
                                                  species: "Salmon",
                                                  bait: "Eggs",
                                                  length: Measurement(value: 32, unit: .inches),
                                                  weight: Measurement(value: 12, unit: .pounds),
                                                  timeCaught: .now,
                                                  temperature: Measurement(value: 76, unit: .fahrenheit),
                                                  waterCondition: .muddy,
                                                  coordinates: CLLocationCoordinate2D(latitude: 45.707115, longitude: -122.656846),
                                                  locationName: "Klineline",
                                                  image: Image("Salmon")))
    }
}
