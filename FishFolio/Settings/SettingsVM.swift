//
//  SettingsVM.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/17/23.
//

import Foundation

class SettingsVM: ObservableObject {
    
    private var crudService: any CRUDService
    
    init(crudService: any CRUDService = StubCRUDService()) {
        self.crudService = crudService
    }
    
    func deleteSpeciesData() {
        crudService.deleteAllSpecies()
    }
    
    func deleteBaitData() {
        crudService.deleteAllBait()
    }
    
    func deleteAllData() {
        crudService.deleteAllFish()
    }
}
