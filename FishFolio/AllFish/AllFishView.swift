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
    
    var testFish = TestFish(species: "Salmon", location: "Klineline", image: true, date: .now, bait: "Worm", weight: "5.4", length: "42", waterCondition: "Muddy")
    
    var demoFish = [
        DemoFish(species: "Salmon", location: "Lewis River", image: true, date: .now),
        DemoFish(species: "Salmon", location: "Lewis River", image: false, date: .now),
        DemoFish(species: "Salmon", location: "Lewis River", image: false, date: .now),
        DemoFish(species: "Salmon", location: "Lewis River", image: true, date: .now),
        DemoFish(species: "Salmon", location: "Lewis River", image: true, date: .now),
        DemoFish(species: "Salmon", location: "Lewis River", image: true, date: .now),
        DemoFish(species: "Salmon", location: "Lewis River", image: true, date: .now),
        DemoFish(species: "Salmon", location: "Lewis River", image: true, date: .now),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(demoFish) { fish in
                    NavigationLink {
                        FishDetailView(fish: testFish)
                    } label: {
                        FishRowView(fish: fish)
                    }
                }
                .onDelete(perform: testDelete)
                .listRowInsets(EdgeInsets())
            }
            .navigationBarTitle("Fish")
        }
    }
    
    func testDelete(at offsets: IndexSet) { }
}

struct AllFishView_Previews: PreviewProvider {
    static var previews: some View {
        AllFishView()
    }
}
