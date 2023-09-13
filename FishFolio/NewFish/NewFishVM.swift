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
    @Published var species: String = ""
    @Published var bait: String = ""
    @Published var length: CustomLength = .init()
    @Published var weight: CustomWeight = .init()
    @Published var timeCaught: Date = .now
    @Published var temperature: Measurement<UnitTemperature>?
    @Published var locationName: String = ""
    @Published var waterCondition: WaterCondition?
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var image: Image?
    
    
    init(crudService: any CRUDService = StubCRUDService()) {
        self.crudService = crudService
    }
    
    func clearForm() {
        species = ""
        bait = ""
        length.whole = nil
        length.decimal = nil
        weight.whole = nil
        weight.decimal = nil
        locationName = ""
        waterCondition = nil
        image = nil
    }
    
    func addFish() {

        let newFish = UIFish(id: UUID(),
                             species: species,
                             bait: bait,
                             length: length.value,
                             weight: weight.value,
                             timeCaught: timeCaught,
                             temperature: temperature,
                             waterCondition: waterCondition,
                             coordinates: coordinates,
                             locationName: locationName,
                             image: image)
        
        crudService.addFish(newFish)
    }
}


