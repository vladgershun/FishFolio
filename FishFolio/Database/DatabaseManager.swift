//
//  DatabaseManager.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/15/23.
//

import Combine
import GRDB
import Foundation
import CoreLocation

struct Species: Codable, FetchableRecord, PersistableRecord {
    var id: String { return speciesName }
    var speciesName: String
}

struct Baits: Codable, FetchableRecord, PersistableRecord {
    var id: String { return baitName }
    var baitName: String
}

class DatabaseManager {
    
    static let shared = DatabaseManager()
    let dbQueue: DatabaseQueue
    let conversionService: any ConversionService
    
    init() {
        conversionService = DBConversionService()
        let fileManager = FileManager.default
        let appSupportURL = try! fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let directoryURL = appSupportURL.appendingPathComponent("Database", isDirectory: true)
        try! fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)

        // Open or create the database
        let databaseURL = directoryURL.appendingPathComponent("db.sqlite")
        dbQueue = try! DatabaseQueue(path: databaseURL.path)
        try! runMigrations()
    }
    
    /// Attempts to create new table and migrates if already exists.
    func runMigrations() throws {
        var migrator = DatabaseMigrator()
        migrator.registerMigration("Create fish") { db in
            try db.create(table: "fishRecord") { t in
                t.primaryKey("id", .text)
                t.column("species", .text)
                t.column("bait", .text)
                t.column("length", .double)
                t.column("weight", .double)
                t.column("timeCaught", .date)
                t.column("temperature", .double)
                t.column("waterCondition", .text)
                t.column("latitude", .double)
                t.column("longitude", .double)
                t.column("locationName", .text)
                t.column("imageID", .text)
            }
        }
        
        migrator.registerMigration("Create species") { db in
            try db.create(table: "species") { t in
                t.primaryKey("id", .text)
                t.column("speciesName", .text)
            }
        }
        
        migrator.registerMigration("Create baits") { db in
            try db.create(table: "baits") { t in
                t.primaryKey("id", .text)
                t.column("baitName", .text)
            }
        }
        
        try migrator.migrate(dbQueue)
    }
    
    /// Fish Operations

    /// Attempts to add `newFish` to database.
    func addFish(_ newFish: DBFish) throws {
        try dbQueue.write { db in
            try FishRecord(id: newFish.id,
                           species: newFish.species,
                           bait: newFish.bait,
                           length: newFish.length,
                           weight: newFish.weight,
                           timeCaught: newFish.timeCaught,
                           temperature: newFish.temperature,
                           waterCondition: newFish.waterCondition,
                           latitude: newFish.latitude,
                           longitude: newFish.longitude,
                           locationName: newFish.locationName,
                           imageID: newFish.imageID)
            .insert(db)
        }
    }
    
    /// Attempts to update `newFish` to database.
    func updateFish(_ newFish: DBFish) throws {
        try dbQueue.write { db in
            try FishRecord(id: newFish.id,
                           species: newFish.species,
                           bait: newFish.bait,
                           length: newFish.length,
                           weight: newFish.weight,
                           timeCaught: newFish.timeCaught,
                           temperature: newFish.temperature,
                           waterCondition: newFish.waterCondition,
                           latitude: newFish.latitude,
                           longitude: newFish.longitude,
                           locationName: newFish.locationName,
                           imageID: newFish.imageID)
            .update(db)
        }
    }
    
    /// Attempts to delete a fish based on `id` in database.
    func deleteFish(for id: DBFish.ID) throws {
        try dbQueue.write { db in
            _ = try FishRecord.deleteOne(db, key: id)
        }
    }
    
    /// Deletes all Fish data
    func deleteAllFish() throws {
        try dbQueue.write { db in
            _ = try FishRecord.deleteAll(db)
        }
    }
    
    /// Returns array of all fish from database.
    func queryAllFish() -> some Publisher<[DBFish], Error> {
        ValueObservation.tracking(FishRecord.fetchAll)
            .publisher(in: dbQueue)
            .map { fish in
                return fish.map { fishRecord in
                    return DBFish(id: fishRecord.id,
                                  species: fishRecord.species,
                                  bait: fishRecord.bait,
                                  length: fishRecord.length,
                                  weight: fishRecord.weight,
                                  timeCaught: fishRecord.timeCaught,
                                  temperature: fishRecord.temperature,
                                  waterCondition: fishRecord.waterCondition,
                                  latitude: fishRecord.latitude,
                                  longitude: fishRecord.longitude,
                                  locationName: fishRecord.locationName,
                                  imageID: fishRecord.imageID)
                }
            }
    }
    
    
    /// Species List Operations
    
    /// Attemps to add `species` to database
    func addSpecies(_ species: String) throws {
        try dbQueue.write { db in
            try Species(speciesName: species)
                .insert(db)
        }
    }
    
    /// Attempts to delete `species` from database
    func deleteSpecies(_ species: String) throws {
        try dbQueue.write { db in
            _ = try Species.deleteOne(db, key: species)
        }
    }
    
    /// Deletes all species from database
    func deleteAllSpecies() throws {
        try dbQueue.write { db in
            _ = try Species.deleteAll(db)
        }
    }
    
    /// Returns array of all species from database
    func querySpeciesList() throws -> [String] {
        try dbQueue.write { db in
            let speciesList = try dbQueue.unsafeReentrantRead { db in
                try Species.fetchAll(db).map { $0.speciesName }
            }
            return speciesList
        }
    }
    
    
    /// Bait List Section
    
    /// Attemps to add `bait` to database
    func addBait(_ bait: String) throws {
        try dbQueue.write { db in
            try Baits(baitName: bait)
                .insert(db)
        }
    }
    
    /// Attempts to delete `bait` from database
    func deleteBait(_ bait: String) throws {
        try dbQueue.write { db in
            _ = try Baits.deleteOne(db, key: bait)
        }
    }
    
    /// Deletes all species from database
    func deleteAllBaits() throws {
        try dbQueue.write { db in
            _ = try Baits.deleteAll(db)
        }
    }
    
    /// Returns array of all species from database
    func queryBaitsList() throws -> [String] {
        try dbQueue.write { db in
            let baitsList = try dbQueue.unsafeReentrantRead { db in
                try Baits.fetchAll(db).map { $0.baitName }
            }
            return baitsList
        }
    }
    
    
    ///
    /// Returns statistics from database.
    ///
    
    func getTotalCaught() -> Int? {
        let totalCaughtRequest: SQLRequest<Int> = "SELECT COUNT(*) FROM catchRecord"

        let totalCaught: Int? = try? dbQueue.read { db in
            try totalCaughtRequest.fetchOne(db)
        }
        
        return totalCaught
    }
    
    func getLargestCatch() -> Double? {
        let largestCatchRequest: SQLRequest<Double> = "SELECT MAX(length) FROM catchRecord"

        let largestCatch: Double? = try? dbQueue.read { db in
            try largestCatchRequest.fetchOne(db)
        }
        return largestCatch
    }

    func getHeaviestCatch() -> Double? {
        let heaviestCatchRequest: SQLRequest<Double> = "SELECT MAX(weight) FROM catchRecord"

        let heaviestCatch: Double? = try? dbQueue.read { db in
            try heaviestCatchRequest.fetchOne(db)
        }
        return heaviestCatch
    }
    
    

}
