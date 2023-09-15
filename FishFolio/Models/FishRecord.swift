//
//  FishRecord.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/15/23.
//

import GRDB
import Foundation

/// Fish structure to be used within database.
struct FishRecord: Codable, FetchableRecord, PersistableRecord {
    
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
