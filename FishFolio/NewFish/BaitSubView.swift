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
    @State var baits = ["Eggs", "Worms", "Corn"]
    
    @State private var selected = false
    
    var body: some View {
        Form {
            Section("Select Bait") {
                List {
                    ForEach(baits, id: \.self) { bait in
                        HStack {
                            Text(bait)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            if self.bait == bait {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            self.bait = bait
                        }
                        .onChange(of: self.bait) { _ in
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
        baits.remove(atOffsets: offsets)
    }
}

struct BaitSubView_Previews: PreviewProvider {
    static var previews: some View {
        BaitSubView(bait: .constant("Eggs"))
    }
}
