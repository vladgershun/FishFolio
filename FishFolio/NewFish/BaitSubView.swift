//
//  NewFormBaitView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import SwiftUI

struct BaitSubView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: NewFishVM
    @Binding var bait: String
    @State private var selected = false
    @State private var searchText = ""
    @State private var newBaidShowing = false
    @State private var newBait = ""
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(searchedBaits, id: \.self) { bait in
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
        .navigationBarTitleDisplayMode(.inline) //Temp fix to spacing bug.
        .searchable(text: $searchText, prompt: "Search Baits")
        .toolbar {
            Button { newBaidShowing = true } label: { Image(systemName: "plus") }
        }
        .alert("Add Bait", isPresented: $newBaidShowing) {
            TextField("", text: $newBait)
            Button("Add"){
                vm.addBait(newBait)
                newBait = ""
                Task {
                    await vm.getBaits()
                }
            }
            Button("Cancel", role: .cancel) { newBait = "" }
        }
        .task {
            await vm.getBaits()
        }
    }
    
    var searchedBaits: [String] {
        if searchText.isEmpty {
            return vm.baitsList
        } else {
            return vm.baitsList.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func testDelete(at offsets: IndexSet) {
        vm.baitsList.remove(atOffsets: offsets)
    }
    
}

struct BaitSubView_Previews: PreviewProvider {
    static var previews: some View {
        BaitSubView(vm: NewFishVM(), bait: .constant("Eggs"))
    }
}
