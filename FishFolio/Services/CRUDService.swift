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
}

struct StubCRUDService: CRUDService {
    
    var db = StubDatabase.shared
    
    func addFish(_ fish: UIFish) {
        db.demoUIFish.append(fish)
    }
    
    func editFish(_ fish: UIFish) {
        
    }
    
    func deleteFish(_ fish: UIFish) {
        if let index = db.demoUIFish.firstIndex(of: fish) {
            db.demoUIFish.remove(at: index)
        }
    }
}
