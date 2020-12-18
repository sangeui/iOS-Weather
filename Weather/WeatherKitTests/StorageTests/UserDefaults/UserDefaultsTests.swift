//
//  UserDefaultsTests.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/17.
//

import XCTest
@testable import WeatherKit

class UserDefaultsTests: XCTestCase {
    
    let suiteForUserDefaults = "UnitTest"
    
    let key = "UnitTestKey"
    
    var defaults: UserDefaults!
    
    func printPlistFilePath() {
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        path.count > 0 ?
            print(path[0]) :
            print("FAILED TO RECEIVING FILE PATH")
    }
    func createUnitDefaults() -> UnitDefaults {
        let keyForUnitDefaults = Key.temperatureUnit
        return UnitDefaults(key: keyForUnitDefaults, defaults: defaults)
    }
    
    override func setUpWithError() throws {
        defaults = UserDefaults(suiteName: suiteForUserDefaults)
        printPlistFilePath()
    }
    override func tearDown() {
        UserDefaults.standard.removePersistentDomain(forName: suiteForUserDefaults)
        defaults = nil
    }

    func testBasicSaveAndLoadOperation() {
        // Given
        let date = String(NSDate().timeIntervalSince1970)
        // When
        defaults.setValue(date, forKey: key)
        // Then
        let savedDate = defaults.string(forKey: key)
        XCTAssertNotNil(savedDate)
        XCTAssertEqual(savedDate, date)
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
