//
//  SpeciesSubView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import SwiftUI

struct SpeciesSubView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var species: String
    @State var allSpecies = ["Salmon", "Trout", "Bass"]
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
        .navigationBarTitleDisplayMode(.inline) //Temp fix to spacing bug.
        .searchable(text: $searchText, prompt: "Search Species")
        .toolbar {
            Button { newSpeciesShowing = true } label: { Image(systemName: "plus") }
        }
        .alert("Add Species", isPresented: $newSpeciesShowing) {
            TextField("", text: $newSpecies)
            Button("Add") { addSpecies(newSpecies) }
            Button("Cancel", role: .cancel) { newSpecies = "" }
        }
    }
    
    var searchedSpecies: [String] {
        if searchText.isEmpty {
            return allSpecies
        } else {
            return allSpecies.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func testDelete(at offsets: IndexSet) {
        // Bug where if you search something and try to delete it will always delete index 0
        allSpecies.remove(atOffsets: offsets)
    }
    
    func addSpecies(_ species: String) {
        if !species.isEmpty && !allSpecies.contains(species) {
            allSpecies.append(species)
            newSpecies = ""
        }
        newSpecies = ""
    }
}

struct SpeciesSubView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesSubView(species: .constant("Salmon"))
    }
}
