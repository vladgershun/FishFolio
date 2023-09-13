//
//  NewFishView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct NewFishView: View {
    
    @StateObject private var vm: NewFishVM = .init()
    @FocusState var isInputActive: Bool
    @State private var length: CustomNumber = .init()
    @State private var weight: CustomNumber = .init()
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
                    createSection
                }
            }
            .navigationTitle("New Fish")
            .toolbar {
                Button { clearForm() } label: { Text("Clear") }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private var speciesSection: some View {
        NavigationLink {
            SpeciesSubView(species: $vm.species)
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
                Text(vm.species)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var baitSection: some View {
        NavigationLink {
            BaitSubView(bait: $vm.bait)
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
                Text(vm.bait)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private var lengthSection: some View {
        DisclosureGroup(isExpanded: $lengthExpanded) {
            HStack(spacing: 0.0) {
                Picker("Whole", selection: $length.whole) {
                    ForEach(0..<100, id: \.self) { whole in
                        Text(whole, format: .number)
                            .tag(whole as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: length.whole) { newValue in
                    if newValue == 0 {
                        length.whole = nil
                    }
                }

                Text(".")

                Picker("Decimal", selection: $length.decimal) {
                    ForEach(0..<10, id: \.self) { decimal in
                        Text(decimal, format: .number)
                            .tag(decimal as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: length.decimal) { newValue in
                    if newValue == 0 {
                        length.decimal = nil
                    }
                }
            }
        } label: {
            HStack {
                LabeledContent("Length", value: length.value.map { Measurement(value: $0, unit: UnitLength.inches) }, format: .measurement(width: .abbreviated))
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
                Picker("Whole", selection: $weight.whole) {
                    ForEach(0..<100, id: \.self) { whole in
                        Text(whole, format: .number)
                            .tag(whole as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: weight.whole) { newValue in
                    if newValue == 0 {
                        weight.whole = nil
                    }
                }

                Text(".")

                Picker("Decimal", selection: $weight.decimal) {
                    ForEach(0..<10, id: \.self) { decimal in
                        Text(decimal, format: .number)
                            .tag(decimal as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: weight.decimal) { newValue in
                    if newValue == 0 {
                        weight.decimal = nil
                    }
                }
            }
        } label: {
            HStack {
                LabeledContent("Weight", value: weight.value.map { Measurement(value: $0, unit: UnitMass.pounds) }, format: .measurement(width: .abbreviated))
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
        TextField("Name", text: $vm.locationName)
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
        Picker("Water Condition", selection: $vm.waterCondition) {
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
    
    private var createSection: some View {
        Button {
            vm.addFish()
            clearForm()
        } label: {
            HStack {
                Spacer()
                Text("Create")
                Spacer()
            }
        }
    }
    
    func clearForm() {
        isInputActive = false
        lengthExpanded = false
        weightExpanded = false
    }
}

struct NewFishView_Previews: PreviewProvider {
    static var previews: some View {
        NewFishView()
    }
}

struct EmptyNilFormatStyle<Base: FormatStyle>: FormatStyle where Base.FormatOutput == String {
    var base: Base
    func format(_ value: Base.FormatInput?) -> String {
        guard let value else {
            return ""
        }
        return base.format(value)
    }
}

extension FormatStyle where FormatOutput == String {
    var emptyOnNil: EmptyNilFormatStyle<Self> {
        EmptyNilFormatStyle(base: self)
    }
}

extension LabeledContent<Text, Text> {
    init<V: Equatable, F: FormatStyle>(_ label: LocalizedStringKey, value: V?, format: F) where F.FormatInput == V, F.FormatOutput == String {
        self.init(label, value: value, format: format.emptyOnNil)
    }
}

struct CustomNumber {
    var whole: Int?
    var decimal: Int?
    
    var value: Double? {
        if let whole {
            return Double(whole) + (Double(decimal ?? 0) * 0.1)
        }
        if let decimal {
            return Double(whole ?? 0) + (Double(decimal) * 0.1)
        }
        return nil
    }
}



