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
                    ForEach(allSpecies, id: \.self) { item in
                        HStack {
                            Text(item)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            if species == item {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.secondary)
                            }
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            print("hit\n\n\n")
                            species = item
                        }
                        .onChange(of: species) { newValue in
                            dismiss()
                        }
                    }
                    .onDelete(perform: testDelete)
                }
                
                
            }
            }
        .toolbar {
            EditButton()
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
