//
//  FishRowView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import SwiftUI
import CoreLocation

struct FishRowView: View {
    
    var fish: UIFish
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(fish.locationName)
                    .font(.title)
                    .bold()
                    .foregroundColor(.primary)
                    
                Spacer()
                
                HStack {
//                    Image(systemName: "fish")
                    Text(fish.species)
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
                
                HStack {
//                    Image(systemName: "calendar")
                    Text(fish.timeCaught, format: Date.FormatStyle().month(.abbreviated).day().year())
                        
                }
                .foregroundColor(.secondary)
                .font(.subheadline)
       
            }
            
            Spacer()
            
            if let image = fish.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 80)
                    .scaledToFill()
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary, lineWidth: 2)
                    )
                    .padding(.trailing)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 100, height: 80)
                    .scaledToFit()
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary, lineWidth: 2)
                    )
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
        FishRowView(fish: UIFish(id: UUID(),
                                 species: "Salmon",
                                 bait: "Eggs",
                                 length: Measurement(value: 32, unit: .inches),
                                 weight: Measurement(value: 12, unit: .pounds),
                                 timeCaught: .now,
                                 temperature: Measurement(value: 76, unit: .fahrenheit),
                                 waterCondition: .muddy,
                                 coordinates: CLLocationCoordinate2D(latitude: 45.707115, longitude: -122.656846),
                                 locationName: "Klineline",
                                 image: UIImage(named: "Salmon")))
            .frame(maxHeight: 100)
    }
}
