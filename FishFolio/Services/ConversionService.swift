//
//  ConversionService.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/15/23.
//

import UIKit
import CoreLocation
import Foundation

protocol ConversionService {
    func encode(fish: UIFish) -> DBFish
    func decode(fish: DBFish) -> UIFish
}

struct DBConversionService: ConversionService {
    
    private let imageManager = ImageManager.shared
    
    func encode(fish: UIFish) -> DBFish {
        return DBFish(id: fish.id,
                      species: fish.species,
                      bait: fish.bait,
                      length: fish.length?.value,
                      weight: fish.weight?.value,
                      timeCaught: fish.timeCaught,
                      temperature: fish.temperature?.value,
                      waterCondition: fish.waterCondition?.description,
                      latitude: fish.coordinates?.latitude,
                      longitude: fish.coordinates?.longitude,
                      locationName: fish.locationName,
                      imageID: fish.id)
        
    }
    
    func decode(fish: DBFish) -> UIFish {
        
        var decodedImage: UIImage? = nil
        
        if let imageID = fish.imageID {
            decodedImage = imageManager.getImage(imageID: imageID, folderName: "FishFolio")
        }
        
        let decodedFish = UIFish(id: fish.id,
                                 species: fish.species,
                                 bait: fish.bait,
                                 length: fish.length.map { Measurement(value: $0, unit: .inches) },
                                 weight: fish.weight.map { Measurement(value: $0, unit: .pounds) },
                                 timeCaught: fish.timeCaught,
                                 temperature: fish.temperature.map { Measurement(value: $0, unit: .fahrenheit) },
                                 waterCondition: fish.waterCondition != nil ? WaterCondition(rawValue: fish.waterCondition!) : nil, // this isnt working
                                 coordinates: fish.latitude != nil ? CLLocationCoordinate2D(latitude: fish.latitude!, longitude: fish.longitude!) : nil,
                                 locationName: fish.locationName,
                                 image: decodedImage)
        
        return decodedFish
    }
}
