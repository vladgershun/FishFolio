//
//  AllFishVM.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import Foundation

@MainActor
class AllFishVM: ObservableObject {
    
    @Published var allFish: [UIFish] = []
    private var fetchService: any FetchService
    private var db = DatabaseManager.shared
    @Published var dbFish: [DBFish] = []
    private var conversionService: any ConversionService
    
    init(fetchService: any FetchService = StubFetchService()) {
        self.fetchService = fetchService
        self.conversionService = DBConversionService()
        
        db.queryAllFish()
            .replaceError(with: [])
            .assign(to: &$dbFish)
        
    }
    
    func task() async {
//        self.allFish = fetchService.getAllFish()
        self.allFish = dbFish.map { conversionService.decode(fish: $0) }
    }
}
