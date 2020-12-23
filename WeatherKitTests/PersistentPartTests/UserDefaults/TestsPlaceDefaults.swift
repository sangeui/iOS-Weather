//
//  TestsPlaceDefaults.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/23.
//

import XCTest
@testable import WeatherKit

class TestsPlaceDefaults: XCTestCase {
    var placeDefaults: PlaceDefaults!
    
    override func setUp() {
        let defaults = UnitTestDefaults.make()
        placeDefaults = PlaceDefaults(key: .place, defaults: defaults!)
    }
    override func tearDown() {
        UnitTestDefaults.clear()
        placeDefaults = nil
    }
    func testSetAndGetPlaces() {
        
    }
}
fileprivate extension UniquePlace {
    static var makePlace
}
