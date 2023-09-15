//
//  DetailVM.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/12/23.
//

import MapKit
import SwiftUI
import Foundation

@MainActor
class DetailVM: ObservableObject {
    
    /// Service used for CRUD operations with data
    private var crudService: any CRUDService
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    /// Local fields for `EditFishView` form submition.
    @Published var updateSpecies: String = ""
    @Published var updateBait: String = ""
    @Published var updateLength: CustomLength = .init()
    @Published var updateWeight: CustomWeight = .init()
    @Published var updateLocationName: String = ""
    @Published var updateWaterCondition: WaterCondition?
    @Published var updateImage: UIImage?
    
    @Published var speciesList: [String] = []
    @Published var baitsList: [String] = []
    
    init(crudService: any CRUDService = StubCRUDService()) {
        self.crudService = crudService
    }
    
    func populateForm(_ fish: UIFish) {
        updateSpecies = fish.species
        updateBait = fish.bait
        updateLength = CustomLength()
        updateWeight = CustomWeight()
        updateLocationName = fish.locationName
        updateWaterCondition = fish.waterCondition
        updateImage = fish.image
    }
    
    func editFish(_ fish: UIFish) {
        
        let _ = UIFish(id: fish.id,
                                 species: updateSpecies,
                                 bait: updateBait,
                                 length: updateLength.value,
                                 weight: updateWeight.value,
                                 timeCaught: fish.timeCaught,
                                 temperature: fish.temperature,
                                 waterCondition: updateWaterCondition,
                                 coordinates: fish.coordinates,
                                 locationName: updateLocationName,
                                 image: updateImage)
    }
    
    func deleteFish(_ fish: UIFish) {
        crudService.deleteFish(fish)
    }
    
    func getSpecies() async {
        self.speciesList = crudService.getSpecies()
    }
    
    func addSpecies(_ species: String) {
        if !speciesList.contains(species) {
            crudService.addSpecies(species)
        }
    }
    
    func deleteSpecies(_ species: String) {
        crudService.deleteSpecies(species)
    }
    
    func getBaits() async {
        self.baitsList = crudService.getBaits()
    }
    
    func addBait(_ bait: String) {
        if !baitsList.contains(bait) {
            crudService.addBait(bait)
        }
    }
    
    func deleteBait(_ bait: String) {
        crudService.deleteBait(bait)
    }

}
