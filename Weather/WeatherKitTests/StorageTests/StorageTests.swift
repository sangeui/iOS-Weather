//
//  StorageTests.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/18.
//

import XCTest
@testable import WeatherKit

class StorageTests: XCTestCase {
    var suiteForUserDefaults = "UnitTest"
    var defaults: UserDefaults!
    var unitDefaults: UnitDefaults!
    var locationsDefaults: LocationsDefaults!
    var storage: Storage!
    
    struct Mock {
        
    }
    
    override func setUp() {
        defaults = UserDefaults(suiteName: suiteForUserDefaults)
        unitDefaults = UnitDefaults(key: Key.temperatureUnit, defaults: defaults)
        locationsDefaults = LocationsDefaults(key: Key.locations, defaults: defaults)
        storage = StorageUserDefaults(unitDefaults, locationsDefaults)
    }
    override func tearDown() {
        UserDefaults.standard.removePersistentDomain(forName: suiteForUserDefaults)
        storage = nil
        unitDefaults = nil
        locationsDefaults = nil
        defaults = nil
    }
    func testSaveAndLoadUnitWhenGivenNewUnit() {
        // Given
        let oldUnit: TemperatureUnit = .celsius
        let newUnit: TemperatureUnit = .fahrenheit
        storage.save(.unit(oldUnit))
        // When
        storage.save(.unit(newUnit))
        // Then
        let unit = storage.load(.unit) as? TemperatureUnit
        XCTAssertNotNil(unit)
        XCTAssertEqual(unit, .fahrenheit)
    }
    func testSaveLocation() {
        // Given
        let timestamp = String(NSDate().timeIntervalSince1970)
        let location = Location(name: "울산광역시",
                                latitude: "35.54638797233825",
                                longitude: "129.2550245164079")
        let userSavedLocation = UserSavedLocation(timestamp: timestamp,
                                                  location: location)
        // When
        storage.save(.location(userSavedLocation))
        // Then
        let savedLocations = storage.load(.locations) as? UserSavedLocations
        XCTAssertNotNil(savedLocations)
        XCTAssertEqual(savedLocations!.count, 1)
    }
    func testSaveLocationWhenExistingLocations() {
        // Given
        
    }
}
