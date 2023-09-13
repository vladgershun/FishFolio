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
    
    init(fetchService: any FetchService = StubFetchService()) {
        self.fetchService = fetchService
    }
    
    func task() async {
        self.allFish = fetchService.getAllFish()
    }
}
