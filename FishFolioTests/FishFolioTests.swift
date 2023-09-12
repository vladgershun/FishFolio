//
//  FishFolioTests.swift
//  FishFolioTests
//
//  Created by Vlad Gershun on 9/11/23.
//

import XCTest
@testable import FishFolio

final class FishFolioTests: XCTestCase {

    func testMeasurements() {
        let kilograms = Measurement(value: 34, unit: UnitMass.pounds).converted(to: .kilograms)
        let pounds = Measurement(value: 34, unit: UnitMass.pounds).converted(to: .pounds)
        
        XCTAssertEqual(kilograms, pounds)
    }

}
