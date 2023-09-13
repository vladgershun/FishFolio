//
//  FetchService.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/12/23.
//

import CoreLocation
import Foundation
import SwiftUI

protocol FetchService {
    func getAllFish() -> [UIFish]
}

struct StubFetchService: FetchService {
    
    let db = StubDatabase.shared
    
    func getAllFish() -> [UIFish] {
        return db.returnAllFish()
    }
}
