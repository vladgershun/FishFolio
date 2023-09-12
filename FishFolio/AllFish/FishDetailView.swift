//
//  FishDetailView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import MapKit
import SwiftUI

struct TestFish: Identifiable {
    let id = UUID()
    var species: String
    var location: String
    var image: Bool
    var date: Date
    var bait: String
    var weight: String
    var length: String
    var waterCondition: String
    var lat = 45.707115
    var long = -122.656846
}


struct FishDetailView: View {
    
    var fish: TestFish
    
    var body: some View {
        Form {
            Section {
                Image("Salmon")
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
                
                HStack {
                    Text("Length")
                    Spacer()
                    Text(fish.length)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Weight")
                    Spacer()
                    Text(fish.weight)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Water Condition")
                    Spacer()
                    Text(fish.waterCondition)
                        .foregroundColor(.secondary)
                }
            }
            
            Section("Location") {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(fish.location)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Temperature")
                    Spacer()
                    Text("76°F")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Water Condition")
                    Spacer()
                    Text(fish.waterCondition)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Date")
                    Spacer()
                    Text(fish.date, format: Date.FormatStyle().day().month().year())
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Time")
                    Spacer()
                    Text(fish.date, format: Date.FormatStyle().hour().minute())
                        .foregroundColor(.secondary)
                }
                
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
 
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.707115,
                                                                                              longitude: -122.656846),
                                                               span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))),
                annotationItems: [fish]) { fish in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: fish.lat,
                                                                 longitude: fish.long)) {
                    MapAnnotationView()
                        .shadow(radius: 10)
                }
            }
            
            
            .listRowInsets(EdgeInsets())
            .cornerRadius(10)
            .aspectRatio(1, contentMode: .fit)
            .allowsHitTesting(false)
            
        }
        
        .navigationTitle(fish.species)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct FishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FishDetailView(fish: TestFish(species: "Salmon", location: "Klineline", image: true, date: .now, bait: "Worm", weight: "5.4", length: "42", waterCondition: "Muddy"))
    }
}
