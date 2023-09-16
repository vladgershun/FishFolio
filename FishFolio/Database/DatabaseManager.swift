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
    
    ///
    /// Attempts to create new table and migrates if already exists.
    ///
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
        try migrator.migrate(dbQueue)
    }
    
    ///
    /// Attempts to add `newFish` to database.
    ///
    func add(_ newFish: DBFish) throws {
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
    
    ///
    /// Attempts to update `newFish` to database.
    ///
    func update(_ newFish: DBFish) throws {
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
    
    func deleteAllFish() throws {
        try dbQueue.write { db in
            _ = try FishRecord.deleteAll(db)
        }
    }
    
    ///
    /// Attempts to delete a fish based on `id` in database.
    ///
    func deleteFish(for id: DBFish.ID) throws {
        try dbQueue.write { db in
            _ = try FishRecord.deleteOne(db, key: id)
        }
    }
    
    ///
    /// Returns array of all fish from database.
    ///
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
