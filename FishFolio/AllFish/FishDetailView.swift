//
//  FishDetailView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import SwiftUI

struct FishDetailView: View {
    var fish: DemoFish
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FishDetailView(fish: DemoFish(species: "Salmon", location: "Lewis River", image: true, date: .now))
    }
}
