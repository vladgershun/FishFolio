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
    func deleteAllFish()
    func getSpecies() -> [String]
    func addSpecies(_ species: String)
    func deleteSpecies(_ species: String)
    func deleteAllSpecies()
    func getBaits() -> [String]
    func addBait(_ bait: String)
    func deleteBait(_ bait: String)
    func deleteAllBait()
}

struct StubCRUDService: CRUDService {
    
    private var db = DatabaseManager.shared
    
    private var conversionService = DBConversionService()
    
    private var imageManager = ImageManager.shared
    
    /// Fish Operations
    func addFish(_ fish: UIFish) {
        if let image = fish.image {
            imageManager.saveImage(image: image, imageID: fish.id, folderName: "FishFolio")
        }
        
        let endcodedFish = conversionService.encode(fish: fish)
        try! db.addFish(endcodedFish)
    } // Done
    
    func editFish(_ fish: UIFish) {
        if let image = fish.image {
            imageManager.saveImage(image: image, imageID: fish.id, folderName: "FishFolio")
        } else {
            imageManager.deleteImage(imageID: fish.id, folderName: "FishFolio")
        }
        
        let encodedFish = conversionService.encode(fish: fish)
        try! db.updateFish(encodedFish)
    } // Done
    
    func deleteFish(_ fish: UIFish) {
        let encodedFish = conversionService.encode(fish: fish)
        try! db.deleteFish(for: encodedFish.id)
    } // Done
    
    func deleteAllFish() {
        try! db.deleteAllFish()
    } // Done
    
    /// Species List Operations
    func getSpecies() -> [String] {
        try! db.querySpeciesList()
    } // Done
    
    func addSpecies(_ species: String) {
        try! db.addSpecies(species)
    } // Done
    
    func deleteSpecies(_ species: String) {
        try! db.deleteSpecies(species)
    }
    
    func deleteAllSpecies() {
        try! db.deleteAllSpecies()
    } // Done
    
    /// Bait List Operations
    func getBaits() -> [String] {
        try! db.queryBaitsList()
    }
    
    func addBait(_ bait: String) {
        try! db.addBait(bait)
    }
    
    func deleteBait(_ bait: String) {
        try! db.deleteBait(bait)
    }
    
    func deleteAllBait() {
        try! db.deleteAllBaits()
    }
}
