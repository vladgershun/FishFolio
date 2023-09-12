//
//  AllFishView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/10/23.
//

import SwiftUI

struct DemoFish: Identifiable {
    let id = UUID()
    var species: String
    var location: String
    var image: Bool
    var date: Date
}

struct AllFishView: View {
    
    @StateObject private var vm: AllFishVM = .init()

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(vm.allFish) { fish in
                    NavigationLink {
                        FishDetailView(fish: fish)
                    } label: {
                        FishRowView(fish: fish)
                    }
                }
                .onDelete(perform: testDelete)
                .listRowInsets(EdgeInsets())
            }
            .navigationBarTitle("Fish")
        }
        .task {
            await vm.task()
        }
    }
        
    
    func testDelete(at offsets: IndexSet) { }
}

struct AllFishView_Previews: PreviewProvider {
    static var previews: some View {
        AllFishView()
    }
}
