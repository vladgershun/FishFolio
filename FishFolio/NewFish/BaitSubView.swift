//
//  NewFormBaitView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import SwiftUI

struct BaitSubView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var bait: String
    let baits = ["Eggs", "Worms", "Corn"]
    
    var body: some View {
        Form {
            Picker("Select Bait", selection: $bait) {
                ForEach(baits, id: \.self) { bait in
                    Text(bait)
                        .onChange(of: self.bait) { _ in
                            dismiss()
                        }
                }
            }
            .pickerStyle(.inline)
        }
        
    }
}

struct BaitSubView_Previews: PreviewProvider {
    static var previews: some View {
        BaitSubView(bait: .constant("Eggs"))
    }
}
