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
    @State private var locationName: String = ""
    
    @State private var lengthExpanded: Bool = false
    @State private var weightExpanded: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("Fish") {
                    NavigationLink {
                        SpeciesSubView(species: $species)
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
                            Text(species)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    
                    NavigationLink {
                        BaitSubView(bait: $bait)
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
                            Text(bait)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    DisclosureGroup(isExpanded: $lengthExpanded) {
                        HStack(spacing: 0.0) {
                            Picker("Whole", selection: $lengthWhole) {
                                ForEach(0..<100, id: \.self) { whole in
                                    Text(whole, format: .number)
                                        .tag(whole as Int?)
                                }
                            }
                            .tint(.secondary)
                            .pickerStyle(.wheel)
                            .onChange(of: lengthWhole) { newValue in
                                if newValue == 0 {
                                    lengthWhole = nil
                                }
                            }
                            
                            Text(".")
                            
                            Picker("Decimal", selection: $lengthDecimal) {
                                ForEach(0..<10, id: \.self) { decimal in
                                    Text(decimal, format: .number)
                                        .tag(decimal as Int?)
                                }
                            }
                            .tint(.secondary)
                            .pickerStyle(.wheel)
                            .onChange(of: lengthDecimal) { newValue in
                                if newValue == 0 {
                                    lengthDecimal = nil
                                }
                            }
                        }
                    } label: {
                        HStack {
                            LabeledContent("Length", value: length.map { Measurement(value: $0, unit: UnitLength.inches) }, format: .measurement(width: .wide))
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
                    
                    DisclosureGroup(isExpanded: $weightExpanded) {
                        HStack(spacing: 0.0) {
                            Picker("Whole", selection: $weightWhole) {
                                ForEach(0..<100, id: \.self) { whole in
                                    Text(whole, format: .number)
                                        .tag(whole as Int?)
                                }
                            }
                            .tint(.secondary)
                            .pickerStyle(.wheel)
                            .onChange(of: weightWhole) { newValue in
                                if newValue == 0 {
                                    weightWhole = nil
                                }
                            }
                            
                            Text(".")
                            
                            Picker("Decimal", selection: $weightDecimal) {
                                ForEach(0..<10, id: \.self) { decimal in
                                    Text(decimal, format: .number)
                                        .tag(decimal as Int?)
                                }
                            }
                            .tint(.secondary)
                            .pickerStyle(.wheel)
                            .onChange(of: weightDecimal) { newValue in
                                if newValue == 0 {
                                    weightDecimal = nil
                                }
                            }
                        }
                    } label: {
                        HStack {
                            LabeledContent("Weight", value: weight.map { Measurement(value: $0, unit: UnitMass.pounds) }, format: .measurement(width: .wide))
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
                
                Section("Location") {
                    TextField("Name", text: $locationName)
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
                    
                    Picker("Water Condition", selection: $waterCondition) {
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
                
                Button {
                    // Add later
                } label: {
                    HStack {
                        Image(systemName: "camera")
                        Text("Add Image")
                    }
                    
                }
                .onTapGesture {
                    withAnimation {
                        weightExpanded = false
                        lengthExpanded = false
                    }
                }
                
                Section {
                    Button { clearForm() } label: {
                        HStack {
                            Spacer()
                            Text("Create")
                            Spacer()
                        }
                        
                    }
                }
            }
            .navigationTitle("New Fish")
            .toolbar {
                Button { clearForm() } label: { Text("Clear") }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    func clearForm() {
        isInputActive = false
        species = ""
        lengthWhole = nil
        lengthDecimal = nil
        weightWhole = nil
        weightDecimal = nil
        bait = ""
        waterCondition = nil
        locationName = ""
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





