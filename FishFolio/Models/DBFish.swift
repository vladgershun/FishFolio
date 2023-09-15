//
//  DBFish.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/15/23.
//

import Foundation

/// Fish structure to be used within database.
struct DBFish: Identifiable {
    
    var id: UUID
    var species: String
    var bait: String
    var length: Double?
    var weight: Double?
    var timeCaught: Date
    var temperature: Double?
    var waterCondition: String?
    var latitude: Double?
    var longitude: Double?
    var locationName: String
    var imageID: UUID?
}

