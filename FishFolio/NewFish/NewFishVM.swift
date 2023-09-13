//
//  NewFishVM.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/12/23.
//

import CoreLocation
import Foundation
import SwiftUI

@MainActor
class NewFishVM: ObservableObject {
    
    /// Service used for CRUD operations with data
    private var crudService: any CRUDService
    
    /// Variables for form
    @Published var newSpecies: String = ""
    @Published var newBait: String = ""
    @Published var newLength: CustomLength = .init()
    @Published var newWeight: CustomWeight = .init()
    @Published var newTimeCaught: Date = .now
    @Published var newTemperature: Measurement<UnitTemperature>?
    @Published var newLocationName: String = ""
    @Published var newWaterCondition: WaterCondition?
    @Published var newCoordinates: CLLocationCoordinate2D?
    @Published var newImage: Image?
    
    @Published var testImage: UIImage?
    
    @Published var speciesList: [String] = []
    @Published var baitsList: [String] = []
    
    
    init(crudService: any CRUDService = StubCRUDService()) {
        self.crudService = crudService
    }
    
    func clearForm() {
        newSpecies = ""
        newBait = ""
        newLength.whole = nil
        newLength.decimal = nil
        newWeight.whole = nil
        newWeight.decimal = nil
        newLocationName = ""
        newWaterCondition = nil
        newImage = nil
    }
    
    func addFish() {

        let newFish = UIFish(id: UUID(),
                             species: newSpecies,
                             bait: newBait,
                             length: newLength.value,
                             weight: newWeight.value,
                             timeCaught: newTimeCaught,
                             temperature: newTemperature,
                             waterCondition: newWaterCondition,
                             coordinates: newCoordinates,
                             locationName: newLocationName,
                             image: newImage)
        
        crudService.addFish(newFish)
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


