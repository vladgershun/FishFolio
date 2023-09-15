//
//  UIFish.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import Foundation
import MapKit
import SwiftUI


/// Fish structure to be used within view.
struct UIFish: Identifiable, Equatable {
    static func == (lhs: UIFish, rhs: UIFish) -> Bool {
        return lhs.id == rhs.id
    }
       
    var id: UUID
    var species: String
    var bait: String
    var length: Measurement<UnitLength>?
    var weight: Measurement<UnitMass>?
    var timeCaught: Date
    var temperature: Measurement<UnitTemperature>?
    var waterCondition: WaterCondition?
    var coordinates: CLLocationCoordinate2D?
    var locationName: String
    var image: UIImage?
}



struct CustomLength {
    var whole: Int?
    var decimal: Int?
    
    var value: Measurement<UnitLength>? {
        if let whole {
            let value = Double(whole) + (Double(decimal ?? 0) * 0.1)
            return Measurement(value: value, unit: .inches)
        }
        if let decimal {
            let value = Double(whole ?? 0) + (Double(decimal) * 0.1)
            return Measurement(value: value, unit: .inches)
        }
        return nil
    }
}

struct CustomWeight {
    var whole: Int?
    var decimal: Int?
    
    var value: Measurement<UnitMass>? {
        if let whole {
            let value = Double(whole) + (Double(decimal ?? 0) * 0.1)
            return Measurement(value: value, unit: .pounds)
        }
        if let decimal {
            let value = Double(whole ?? 0) + (Double(decimal) * 0.1)
            return Measurement(value: value, unit: .pounds)
        }
        return nil
    }
}
