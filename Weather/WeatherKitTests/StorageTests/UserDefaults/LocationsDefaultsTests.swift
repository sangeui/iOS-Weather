//
//  LocationsDefaultsTests.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/17.
//

import XCTest
@testable import WeatherKit

class LocationsDefaultsTests: XCTestCase {
    var suiteForUserDefaults = "UnitTest"
    var defaults: UserDefaults!
    var locationsDefaults: LocationsDefaults!
    
    override func setUp() {
        defaults = UserDefaults(suiteName: suiteForUserDefaults)
        locationsDefaults = LocationsDefaults(key: Key.locations, defaults: defaults)
    }
    override func tearDown() {
        UserDefaults.standard.removePersistentDomain(forName: suiteForUserDefaults)
        locationsDefaults = nil
        defaults = nil
    }
    func testIsEmptyWhenFirstCreated() {
        XCTAssertNil(locationsDefaults.value)
    }
    func testSaveOneLocation() {
        let timestamp = makeTimeStamp()
        let placeName = "Ulsan"
        let coordination = Coordination(latitude: 35.5, longitude: 129.3)
        let location = Place(coordination: coordination, name: placeName)
        let identifiableLocation = IdentifiablePlace(location: location, timestamp: timestamp)
        
        locationsDefaults.value = [identifiableLocation]
        
        let loadedLocations = locationsDefaults.value
        XCTAssertNotNil(loadedLocations)
        XCTAssertEqual(loadedLocations?.count, 1)
    }
    private func makeTimeStamp() -> String {
        return String(NSDate().timeIntervalSince1970)
    }
}
