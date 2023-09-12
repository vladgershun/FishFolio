//
//  FishModel.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import Foundation
import SwiftUI

struct Fish: Identifiable {
    
    var id: UUID
    var species: String
    var bait: String
    var length: String
    var weight: String
    var timeCaught: Date
    var temperature: String
    var waterCondition: WaterCondition
    var latitude: Double
    var longitude: Double
    var locationName: String
    var image: Image
}

