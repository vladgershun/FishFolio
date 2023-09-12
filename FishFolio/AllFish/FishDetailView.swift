//
//  FishDetailView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import MapKit
import SwiftUI

struct FishDetailView: View {
    
    var fish: UIFish
    
    var body: some View {
        Form {
            Section {
                fish.image?
                    .resizable()
                    .cornerRadius(10)
                    .scaledToFit()
                    .listRowInsets(EdgeInsets())
            }
            
            Section("Metrics") {
                HStack {
                    Text("Species")
                    Spacer()
                    Text(fish.species)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Bait")
                    Spacer()
                    Text(fish.bait)
                        .foregroundColor(.secondary)
                }
                
                LabeledContent("Length", value: Measurement(value: 32, unit: UnitLength.inches), format: .measurement(width: .wide))
                
                LabeledContent("Weight", value: Measurement(value: 32, unit: UnitMass.pounds), format: .measurement(width: .wide))
                
                HStack {
                    Text("Water Condition")
                    Spacer()
                    Text(fish.waterCondition.description)
                        .foregroundColor(.secondary)
                }
            }
            
            Section("Location") {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(fish.locationName)
                        .foregroundColor(.secondary)
                }
                
                LabeledContent("Temperature", value: Measurement(value: 76, unit: UnitTemperature.fahrenheit), format: .measurement(width: .abbreviated))
                
                HStack {
                    Text("Water Condition")
                    Spacer()
                    Text(fish.waterCondition.description)
                        .foregroundColor(.secondary)
                }
                
                LabeledContent("Date", value: fish.timeCaught, format: Date.FormatStyle().day().month().year())
                LabeledContent("Time", value: fish.timeCaught, format: Date.FormatStyle().hour().minute())
               
                HStack {
                    Text("Latitude")
                    Spacer()
                    Text("45.707115")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Longitude")
                    Spacer()
                    Text("-122.656846")
                        .foregroundColor(.secondary)
                }
            }
 
            Section {
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.707115, longitude: -122.656846),
                                                                   span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))),
                    annotationItems: [fish]) { fish in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: fish.coordinates.latitude, longitude: fish.coordinates.longitude)) {
                        MapAnnotationView()
                            .shadow(radius: 10)
                    }
                }
                .listRowInsets(EdgeInsets())
                .cornerRadius(10)
                .aspectRatio(1, contentMode: .fit)
                .allowsHitTesting(false)
            }
            
            HStack {
                Spacer()
                Button(role: .destructive) { } label: {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete Fish")
                    }
                    
                }
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button { } label: { Image(systemName: "square.and.pencil") }
        }
    }
}

struct FishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FishDetailView(fish: UIFish(id: UUID(),
                                    species: "Salmon",
                                    bait: "Eggs",
                                    length: Measurement(value: 32, unit: .inches),
                                    weight: Measurement(value: 12, unit: .pounds),
                                    timeCaught: .now,
                                    temperature: Measurement(value: 76, unit: .fahrenheit),
                                    waterCondition: .muddy,
                                    coordinates: CLLocationCoordinate2D(latitude: 45.707115, longitude: -122.656846),
                                    locationName: "Klineline",
                                    image: Image("Salmon")))
    }
}
