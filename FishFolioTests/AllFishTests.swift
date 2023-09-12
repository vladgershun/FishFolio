//
//  FishFolioTests.swift
//  FishFolioTests
//
//  Created by Vlad Gershun on 9/11/23.
//

import XCTest
@testable import FishFolio
import CoreLocation
import os
import SwiftUI

// given -> when -> then

@MainActor
final class AllFishTests: XCTestCase {
    
    static let stubFish = [
        UIFish(
            id: UUID(),
            species: "Salmon",
            bait: "Eggs",
            length: Measurement(value: 32, unit: .inches),
            weight: Measurement(value: 12, unit: .pounds),
            timeCaught: .now,
            temperature: Measurement(value: 76, unit: .fahrenheit),
            waterCondition: .muddy,
            coordinates: CLLocationCoordinate2D(latitude: 45.707115, longitude: -122.656846),
            locationName: "Klineline",
            image: Image("Salmon")
        )
    ]

    func testAllFishStartsEmpty() async {
        let vm = AllFishVM(fetchService: StubFetchService())
        let allFish = vm.allFish
        
        XCTAssertEqual(allFish.count, 0)
    }
    
    func testAllFishTaskRun() async {
        let vm = AllFishVM(fetchService: StubFetchService())
        let task = Task {
            //
            await vm.task()
        }
        
        for await allFish in vm.$allFish.values {
            XCTAssertEqual(allFish.count, 1)
            break
        }
        
        task.cancel()
        await task.value
    }
    
    func testQueues() {
        //how does this play into swift concurrency
        let concurrent = DispatchQueue(label: "my-concurrent-queue", qos: .background, attributes: .concurrent)
        
        let serial1 = DispatchQueue(label: "my-queue2", target: concurrent)
        let serial2 = DispatchQueue(label: "my-queue1", target: concurrent)
        
        let results = OSAllocatedUnfairLock<[String]>(initialState: [])
        
        serial1.async {
            results.withLock { $0.append("A") }
        }
        serial1.async {
            results.withLock { $0.append("B") }
        }
        serial2.async {
            results.withLock { $0.append("1") }
        }
        serial2.async {
            results.withLock { $0.append("2") }
        }
        serial1.sync {
            
        }
        serial2.sync {
            
        }
        let r = results.withLock { $0 }
        XCTAssertTrue(r.firstIndex(of: "A")! < r.firstIndex(of: "B")!)
        XCTAssertTrue(r.firstIndex(of: "1")! < r.firstIndex(of: "2")!)
//        XCTAssertEqual(results.withLock { $0.joined() }, "AB12")
    }
}
