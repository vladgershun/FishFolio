//
//  FishDetailView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import MapKit
import SwiftUI

struct FishDetailView: View {
    
    @StateObject private var vm: DetailVM = .init()
    var fish: UIFish
    @State var isEditShowing = false
    
    var body: some View {
        Form {
            Section {
                imageSection
            }
            
            Section("Metrics") {
                metricsSection
            }
            
            Section("Location") {
                locationSection
            }
            
            mapSection
            deleteButtonSection
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isEditShowing) {
            EditFishView(vm: vm, fish: fish)
        }
        .toolbar {
            Button {
                vm.populateForm(fish)
                isEditShowing = true
            } label: {
                Image(systemName: "square.and.pencil")
            }
        }
    }
    
    private var imageSection: some View {
        fish.image?
            .resizable()
            .cornerRadius(10)
            .scaledToFit()
            .listRowInsets(EdgeInsets())
    }
    
    private var metricsSection: some View {
        Group {
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
            if let length = fish.length {
                LabeledContent("Length", value: length, format: .measurement(width: .abbreviated))
            }
            if let weight = fish.weight {
                LabeledContent("Weight", value: weight, format: .measurement(width: .abbreviated))
            }
        }
    }
    
    private var locationSection: some View {
        Group {
            HStack {
                Text("Name")
                Spacer()
                Text(fish.locationName)
                    .foregroundColor(.secondary)
            }
            
            if let temperature = fish.temperature {
                LabeledContent("Temperature", value: temperature, format: .measurement(width: .abbreviated))
            }
            
            
            if let waterCondition = fish.waterCondition {
                HStack {
                    Text("Water Condition")
                    Spacer()
                    Text(waterCondition.description)
                        .foregroundColor(.secondary)
                }
            }
            
            LabeledContent("Date", value: fish.timeCaught, format: Date.FormatStyle().day().month().year())
            LabeledContent("Time", value: fish.timeCaught, format: Date.FormatStyle().hour().minute())
           
            if let latitude = fish.coordinates?.latitude {
                HStack {
                    Text("Latitude")
                    Spacer()
                    Text(latitude, format: .number)
                        .foregroundColor(.secondary)
                }
            }
            
            if let longitude = fish.coordinates?.longitude {
                HStack {
                    Text("Longitude")
                    Spacer()
                    Text(longitude, format: .number)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var mapSection: some View {
        Group {
            if let coordinates = fish.coordinates {
                Section {
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: coordinates,
                                                                       span: vm.mapSpan)),
                        annotationItems: [fish]) { fish in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)) {
                            MapAnnotationView()
                                .shadow(radius: 10)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .cornerRadius(10)
                    .aspectRatio(1, contentMode: .fit)
                    .allowsHitTesting(false)
                }
            }
        }
    }
    
    private var deleteButtonSection: some View {
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
