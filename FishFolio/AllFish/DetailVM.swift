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
    @Published var newSpecies: String = ""
    @Published var newBait: String = ""
    @Published var newLength: CustomLength = .init()
    @Published var newWeight: CustomWeight = .init()
    @Published var newLocationName: String = ""
    @Published var newWaterCondition: WaterCondition?
    @Published var newImage: Image?
    
    @Published var speciesList: [String] = []
    @Published var baitsList: [String] = []
    
    init(crudService: any CRUDService = StubCRUDService()) {
        self.crudService = crudService
    }
    
    func populateForm(_ fish: UIFish) {
        newSpecies = fish.species
        newBait = fish.bait
        newLength = CustomLength()
        newWeight = CustomWeight()
        newLocationName = fish.locationName
        newWaterCondition = fish.waterCondition
        newImage = fish.image
    }
    
    func editFish(_ fish: UIFish) { }
    
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
