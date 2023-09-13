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
    @State private var lengthExpanded: Bool = false
    @State private var weightExpanded: Bool = false
    @State private var pickerShowing = false
    
    @State private var photoOptionShowing = false
    @State private var isCamera = true
    
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
                
                
                        
                if let image = vm.newImage {
                    Section {
                        ZStack(alignment: .bottomTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .cornerRadius(10)
                                .scaledToFit()
                            Button(role: .destructive) {
                                vm.newImage = nil
                            } label: {
                                Image(systemName: "trash")
                                    .font(.largeTitle)
                            }
                            .padding()
                        }
                        
                        
                    }.listRowInsets(EdgeInsets())
                    
                    
                }
                
                Section {
                    imageSection
                }

                Section {
                    createButtonSection
                        .disabled(vm.newSpecies == "" || vm.newBait == "" || vm.newLocationName == "")
                }
            }
            .navigationTitle("New Fish")
            .toolbar {
                Button {
                    vm.clearForm()
                    isInputActive = false
                    lengthExpanded = false
                    weightExpanded = false
                } label: {
                    Text("Clear")
                }
            }
            .fullScreenCover(isPresented: $pickerShowing){
                ImagePicker(sourceType: isCamera ? .camera : .photoLibrary, selectedImage: $vm.newImage)
                    .ignoresSafeArea()
            }
        }
        .navigationViewStyle(.stack)
        .confirmationDialog("Select Photo Option", isPresented: $photoOptionShowing) {
            Button("Camera") {
                isCamera = true
                pickerShowing = true
            }
            Button("Photo Library") {
                isCamera = false
                pickerShowing = true
            }
        } message: {
            Text("Select Option")
        }
    }
    
    private var speciesSection: some View {
        NavigationLink {
            SpeciesSubView(vm: vm, species: $vm.newSpecies)
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
            BaitSubView(vm: vm, bait: $vm.newBait)
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
            photoOptionShowing = true
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
            vm.addFish()
            vm.clearForm()
            isInputActive = false
            lengthExpanded = false
            weightExpanded = false
        } label: {
            HStack {
                Spacer()
                Text("Create")
                Spacer()
            }
        }
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





