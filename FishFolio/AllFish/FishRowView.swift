//
//  FishRowView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import SwiftUI

struct FishRowView: View {
    
    var fish: DemoFish
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(fish.species)
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                    
                Spacer()
                
                HStack {
                    Image(systemName: "globe")
                    Text(fish.location)
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
                
                HStack {
                    Image(systemName: "calendar")
                    Text(fish.date, format: Date.FormatStyle().month(.abbreviated).day().year())
                        
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
       
            }
            
            Spacer()
            
            if fish.image {
                Image("Salmon")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary, lineWidth: 2)
                    )
                    .frame(width: 80, height: 80)
                    .padding(.trailing)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary, lineWidth: 2)
                    )
                    .frame(width: 80, height: 80)
                    .padding(.trailing)
            }
        }
        .padding()
        
        .background (
            RoundedRectangle(cornerRadius: 10)
                .fill(Material.thickMaterial)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
            
        )
        .padding([.leading, .trailing])
        .padding([.top, .bottom], 6)
    }
}

struct FishRowView_Previews: PreviewProvider {
    static var previews: some View {
        FishRowView(fish: DemoFish(species: "Salmon", location: "Lewis River", image: true, date: .now))
            .frame(maxHeight: 100)
    }
}
