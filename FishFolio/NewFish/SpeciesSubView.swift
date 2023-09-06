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
    
    var body: some View {
        Form {
            Section("Select Species") {
                List {
                    ForEach(allSpecies, id: \.self) { species in
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
        .toolbar {
            Button { } label: { Image(systemName: "plus") }
        }
    }
    
    func testDelete(at offsets: IndexSet) {
        allSpecies.remove(atOffsets: offsets)
    }
}

struct SpeciesSubView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesSubView(species: .constant("Salmon"))
    }
}
