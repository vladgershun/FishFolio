//
//  ConversionService.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/15/23.
//

import CoreLocation
import Foundation

protocol ConversionService {
    func encode(fish: UIFish) -> DBFish
    func decode(fish: DBFish) -> UIFish
}

struct DBConversionService: ConversionService {
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
        
       
        var length: Measurement<UnitLength>? {
            if let unwrappedLength = fish.length {
                return Measurement(value: unwrappedLength, unit: .inches)
            } else {
                return nil
            }
        }
        
        
        
        let decodedFish = UIFish(id: fish.id,
                                 species: fish.species,
                                 bait: fish.bait,
                                 length: fish.length.map { Measurement(value: $0, unit: .inches) },
//                                 length: fish.length != nil ? Measurement(value: fish.length!, unit: .inches) : nil,
                                 weight: fish.weight.map { Measurement(value: $0, unit: .pounds) },
                                 timeCaught: fish.timeCaught,
                                 temperature: fish.temperature.map { Measurement(value: $0, unit: .fahrenheit) },
                                 waterCondition: nil,
                                 coordinates: nil,
                                 locationName: fish.locationName,
                                 image: nil)
        
        return decodedFish
    }
}
