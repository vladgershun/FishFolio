//
//  UIFishModel.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import Foundation
import MapKit
import SwiftUI


/// Fish structure to be used within view.
struct UIFish: Identifiable {
    
    var id: UUID
    var species: String
    var bait: String
    var length: Measurement<UnitLength>
    var weight: Measurement<UnitMass>
    var timeCaught: Date
    var temperature: Measurement<UnitTemperature>
    var waterCondition: WaterCondition
    var coordinates: CLLocationCoordinate2D
    var locationName: String
    var image: Image?
}

