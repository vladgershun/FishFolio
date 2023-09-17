//
//  CRUDService.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/12/23.
//

import Foundation

protocol CRUDService {
    func addFish(_ fish: UIFish)
    func editFish(_ fish: UIFish)
    func deleteFish(_ fish: UIFish)
    func getSpecies() -> [String]
    func addSpecies(_ species: String)
    func deleteSpecies(_ species: String)
    func getBaits() -> [String]
    func addBait(_ bait: String)
    func deleteBait(_ bait: String)
}

struct StubCRUDService: CRUDService {
    
    private var db = StubDatabase.shared
    
    private var database = DatabaseManager.shared
    
    private var conversionService = DBConversionService()
    
    private var imageManager = ImageManager.shared
    
    func addFish(_ fish: UIFish) {
        
        if let image = fish.image {
            imageManager.saveImage(image: image, imageID: fish.id, folderName: "FishFolio")
        }
        
        let endcodedFish = conversionService.encode(fish: fish)
        try! database.add(endcodedFish)
    }
    
    func editFish(_ fish: UIFish) {
        if let image = fish.image {
            imageManager.saveImage(image: image, imageID: fish.id, folderName: "FishFolio")
        }
        
        let encodedFish = conversionService.encode(fish: fish)
        try! database.update(encodedFish)
    }
    
    func deleteFish(_ fish: UIFish) {
        let encodedFish = conversionService.encode(fish: fish)
        try! database.deleteFish(for: encodedFish.id)
    }
    
    func getSpecies() -> [String] {
        
        let x = try? database.querySpeciesList()
        return db.returnSpecies()
    }
    
    func addSpecies(_ species: String) {
        db.demoSpecies.append(species)
        try! database.addSpecies(species)
    }
    
    func deleteSpecies(_ species: String) {
        if let index = db.demoSpecies.firstIndex(of: species) {
            db.demoSpecies.remove(at: index)
        }
    }
    
    func getBaits() -> [String] {
        return db.returnBaits()
    }
    
    func addBait(_ bait: String) {
        db.demoBaits.append(bait)
    }
    
    func deleteBait(_ bait: String) {
        if let index = db.demoBaits.firstIndex(of: bait) {
            db.demoBaits.remove(at: index)
        }
    }
    
    
}
