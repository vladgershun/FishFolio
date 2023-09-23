//
//  StatisticsVM.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/20/23.
//

import Foundation

class StatisticsVM: ObservableObject {
    
    private var crudService: any CRUDService
    
    @Published var totalFish = 0
    @Published var largestFish = 0.0
    @Published var heaviestFish = 0.0
    
    init(crudService: any CRUDService = StubCRUDService(), totalFish: Int, largestFish: Double, heaviestFish: Double) {
        self.crudService = crudService
        self.totalFish = crudService.totalFish()
        self.largestFish = crudService.largestFish()
        self.heaviestFish = crudService.heaviestFish()
    }
}
