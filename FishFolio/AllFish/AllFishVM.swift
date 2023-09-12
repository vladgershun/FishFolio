//
//  AllFishVM.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import Foundation
import SwiftUI
import MapKit

protocol FetchService {
    func fetchAllFish() -> [UIFish]
}

class StubFetchService: FetchService {
    
    let demoUIFish = UIFish(id: UUID(),
                            species: "Salmon",
                            bait: "Eggs",
                            length: Measurement(value: 32, unit: .inches),
                            weight: Measurement(value: 12, unit: .pounds),
                            timeCaught: .now,
                            temperature: Measurement(value: 76, unit: .fahrenheit),
                            waterCondition: .muddy,
                            coordinates: CLLocationCoordinate2D(latitude: 45.707115, longitude: -122.656846),
                            locationName: "Klineline",
                            image: Image("Salmon"))
    
    func fetchAllFish() -> [UIFish] {
        return [demoUIFish]
    }
}

class DBFetchService: FetchService {
    
    let demoUIFish = UIFish(id: UUID(),
                            species: "Salmon",
                            bait: "Eggs",
                            length: Measurement(value: 32, unit: .inches),
                            weight: Measurement(value: 12, unit: .pounds),
                            timeCaught: .now,
                            temperature: Measurement(value: 76, unit: .fahrenheit),
                            waterCondition: .muddy,
                            coordinates: CLLocationCoordinate2D(latitude: 45.707115, longitude: -122.656846),
                            locationName: "Klineline",
                            image: Image("Salmon"))
    
    func fetchAllFish() -> [UIFish] {
        return [demoUIFish]
    }
}

@MainActor
class AllFishVM: ObservableObject {
    
    @Published var allFish: [UIFish] = []
    private var fetchService: any FetchService
    
    init(fetchService: any FetchService = StubFetchService()) {
        self.fetchService = fetchService
    }
    
    func task() async {
        self.allFish = fetchService.fetchAllFish()
    }
}
