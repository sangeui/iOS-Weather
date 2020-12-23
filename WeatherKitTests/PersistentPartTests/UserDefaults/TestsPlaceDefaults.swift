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
        let place = UniquePlace.randomPlace
        let timestamp = String(NSDate().timeIntervalSince1970)
        let uniquePlace = UniquePlace(place: place, timestamp: timestamp)
        
        XCTAssertNil(placeDefaults.value)
        
        placeDefaults.value = [uniquePlace]
        
        let savedPlace = placeDefaults.value
        
        XCTAssertNotNil(savedPlace)
        XCTAssertEqual(savedPlace!.count, 1)
        XCTAssertEqual(savedPlace!, [uniquePlace])
    }
    func testNothingHappendWhenPassedNil() {
        let place = UniquePlace.randomPlace
        let timestamp = String(NSDate().timeIntervalSince1970)
        let uniquePlace = UniquePlace(place: place, timestamp: timestamp)
        
        placeDefaults.value = [uniquePlace]
        placeDefaults.value = nil
        
        let savedPlace = placeDefaults.value
        
        XCTAssertNotNil(savedPlace)
        XCTAssertEqual(savedPlace!, [uniquePlace])
    }
}
