//
//  TestsUnitDefaults.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/23.
//

import XCTest
@testable import WeatherKit

class TestsUnitDefaults: XCTestCase {
    var unitDefaults: UnitDefaults!
    
    override func setUp() {
        let defaults = UnitTestDefaults.make()
        unitDefaults = UnitDefaults(key: .unit, defaults: defaults!)
    }
    override func tearDown() {
        UnitTestDefaults.clear()
        unitDefaults = nil
    }
    func testNoSavedUnitWhenFirstCreated() {
        XCTAssertNil(unitDefaults.value)
    }
    func testNothingIsSavedWhenNilIsPassed() {
        unitDefaults.value = nil
        XCTAssertNil(unitDefaults.value)
    }
    func testSetAndGetUnitGivenInitialOne() {
        let initUnit: TemperatureUnit = .celsius
        
        unitDefaults.value = initUnit
        let storedUnit = unitDefaults.value
        
        XCTAssertEqual(storedUnit, .celsius)
    }
    func testSetAndGetUnitWhenGivenSavedUnit() {
        let before: TemperatureUnit = .fahrenheit
        let after: TemperatureUnit = .celsius
        unitDefaults.value = before
        
        XCTAssertEqual(unitDefaults.value!, .fahrenheit)
        unitDefaults.value = after
        
        XCTAssertEqual(unitDefaults.value!, .celsius)
    }
}
