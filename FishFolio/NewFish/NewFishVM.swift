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
    @Published var length: Measurement<UnitLength>?
    @Published var weight: Measurement<UnitMass>?
    @Published var timeCaught: Date = .now
    @Published var temperature: Measurement<UnitTemperature>?
    @Published var waterCondition: WaterCondition?
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var locationName: String = ""
    @Published var image: UIImage?
    
    
    init(crudService: any CRUDService = StubCRUDService()) {
        self.crudService = crudService
    }
    
    func addFish() {
//        crudService.addFish()
    }
}


