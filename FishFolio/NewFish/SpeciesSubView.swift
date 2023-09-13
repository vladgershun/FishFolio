//
//  SpeciesSubView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import SwiftUI

struct SpeciesSubView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: NewFishVM
    @Binding var species: String
    @State private var selected = false
    @State private var searchText = ""
    @State private var newSpeciesShowing = false
    @State private var newSpecies = ""
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(searchedSpecies, id: \.self) { species in
                        HStack {
                            Text(species)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            if self.species == species {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.species = species
                        }
                        .onChange(of: self.species) { _ in
                            dismiss()
                        }
                    }
                    .onDelete(perform: testDelete)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: "Search Species")
        .toolbar {
            Button { newSpeciesShowing = true } label: { Image(systemName: "plus") }
        }
        .alert("Add Species", isPresented: $newSpeciesShowing) {
            TextField("", text: $newSpecies)
            Button("Add") {
                vm.addSpecies(newSpecies)
                newSpecies = ""
                Task {
                   await vm.getSpecies()
                }
            }
            Button("Cancel", role: .cancel) { newSpecies = "" }
        }
        .task {
            await vm.getSpecies()
        }
    }
    
    var searchedSpecies: [String] {
        if searchText.isEmpty {
            return vm.speciesList
        } else {
            return vm.speciesList.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func testDelete(at offsets: IndexSet) {
        // Bug where if you search something and try to delete it will always delete index 0
        vm.speciesList.remove(atOffsets: offsets)
    }
    
}

struct SpeciesSubView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesSubView(vm: NewFishVM(), species: .constant("Salmon"))
    }
}
