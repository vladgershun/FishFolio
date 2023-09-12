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
    @StateObject private var vm: DetailVM = .init()
    
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
                LabeledContent("Length", value: fish.length, format: .measurement(width: .abbreviated))
                LabeledContent("Weight", value: fish.weight, format: .measurement(width: .abbreviated))
            }
            
            Section("Location") {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(fish.locationName)
                        .foregroundColor(.secondary)
                }
                
                LabeledContent("Temperature", value: fish.temperature, format: .measurement(width: .abbreviated))
                
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
                    Text(fish.coordinates.latitude, format: .number)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Longitude")
                    Spacer()
                    Text(fish.coordinates.longitude, format: .number)
                        .foregroundColor(.secondary)
                }
            }
 
            Section {
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: fish.coordinates,
                                                                   span: vm.mapSpan)),
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
                Button(role: .destructive) {
                    vm.deleteFish(fish)
                } label: {
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
            Button {
                vm.editFish(fish)
            } label: {
                Image(systemName: "square.and.pencil")
            }
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
