//
//  UnitDefaultsTests.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/17.
//

import XCTest
@testable import WeatherKit

class UnitDefaultsTests: XCTestCase {
    let suiteForUserDefaults = "UnitTest"
    var defaults: UserDefaults!

    func createUnitDefaults() -> UnitDefaults {
        let keyForUnitDefaults = Key.temperatureUnit
        return UnitDefaults(key: keyForUnitDefaults, defaults: defaults)
    }
    override func setUpWithError() throws {
        defaults = UserDefaults(suiteName: suiteForUserDefaults)
    }
    override func tearDown() {
        UserDefaults.standard.removePersistentDomain(forName: suiteForUserDefaults)
        defaults = nil
    }
    func testUnitSaveLoadOperation() {
        // Given
        var unitDefaults = createUnitDefaults()
        let unit: TemperatureUnit = .celsius
        // When
        unitDefaults.value = unit
        // Then
        let savedUnit = unitDefaults.value
        XCTAssertNotNil(savedUnit)
        XCTAssertEqual(savedUnit!, .celsius)
    }
    func testUnitChangeOperation() {
        // Given
        var unitDefaults = createUnitDefaults()
        let oldUnit: TemperatureUnit = .celsius
        let newUnit: TemperatureUnit = .fahrenheit
        XCTAssertNil(unitDefaults.value)
        
        // When
        unitDefaults.value = oldUnit
        let loadedOldUnit = unitDefaults.value
        XCTAssertNotNil(loadedOldUnit)
        unitDefaults.value = newUnit
        
        //Then
        let loadedNewUnit = unitDefaults.value
        XCTAssertNotNil(loadedNewUnit)
        XCTAssertEqual(loadedNewUnit, .fahrenheit)
    }
}
