//
//  StubDatabase.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/12/23.
//

import Foundation

import CoreLocation
import SwiftUI

class StubDatabase {
    
    static let shared = StubDatabase()
    
    var demoUIFish = [UIFish(id: UUID(),
                             species: "Salmon",
                             bait: "Eggs",
                             length: Measurement(value: 13, unit: .inches),
                             weight: Measurement(value: 2, unit: .pounds),
                             timeCaught: .now,
                             temperature: Measurement(value: 71, unit: .fahrenheit),
                             waterCondition: .muddy,
                             coordinates: CLLocationCoordinate2D(latitude: 45.707115, longitude: -122.656846),
                             locationName: "Klineline",
                             image: Image("Salmon")),
                      UIFish(id: UUID(),
                             species: "Salmon",
                             bait: "Eggs",
                             length: Measurement(value: 24, unit: .inches),
                             weight: Measurement(value: 12, unit: .pounds),
                             timeCaught: .now,
                             temperature: Measurement(value: 76, unit: .fahrenheit),
                             waterCondition: .muddy,
                             coordinates: CLLocationCoordinate2D(latitude: 45.607115, longitude: -122.756846),
                             locationName: "Klineline",
                             image: nil)]
    
    var demoSpecies = ["Salmon", "Trout", "Bass"]
    var demoBaits = ["Eggs", "Worms", "Corn"]
    
    private init() {}
    
    func returnAllFish() -> [UIFish] { return demoUIFish }
    func returnSpecies() -> [String] { return demoSpecies}
    func returnBaits() -> [String] { return demoBaits }
    
}
