//
//  LocationsDefaultsTests.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/17.
//

import XCTest
@testable import WeatherKit

struct LocationsMock {
    static let single: UserSavedLocations = {
        ["976958485":Location(name: "울산광역시",
                     latitude: "35.54638797233825",
                     longitude: "129.2550245164079")]
    } ()
    static var multiple: UserSavedLocations = {
        [
            "976958485":Location(name: "울산광역시",
                         latitude: "35.54638797233825",
                         longitude: "129.2550245164079"),
            "976953485":Location(name: "부산광역시",
                         latitude: "35.157412762089876",
                         longitude: "129.0529154489389"),
            "976956485":Location(name: "서울특별시",
                         latitude: "37.5588741968296",
                         longitude: "126.9603464268635"),
            "976952485":Location(name: "광주광역시",
                         latitude: "35.15254241428494",
                         longitude: "126.86851743859148"),
            "976958445":Location(name: "대구광역시",
                         latitude: "35.85190699453727",
                         longitude: "128.54369559251353"),
            "976928485":Location(name: "제주특별자치도",
                         latitude: "33.496635256495146",
                         longitude: "126.53180143471292"),
        ]
    } ()
}

class LocationsDefaultsTests: XCTestCase {
    let suiteForUserDefaults = "UnitTest"
    var defaults: UserDefaults!
    var locationsDefaults: LocationsDefaults!

    func createLocationsDefaults() -> LocationsDefaults {
        let keyForUnitDefaults = Key.locations
        return LocationsDefaults(key: keyForUnitDefaults, defaults: defaults)
    }
    override func setUpWithError() throws {
        defaults = UserDefaults(suiteName: suiteForUserDefaults)
        locationsDefaults = createLocationsDefaults()
    }
    override func tearDown() {
        UserDefaults.standard.removePersistentDomain(forName: suiteForUserDefaults)
        defaults = nil
        locationsDefaults = nil
    }
    func testUserSavedLocationSaveLoadOperation() {
        // Given
        let singleUserSavedLocation = LocationsMock.single
        locationsDefaults.value = singleUserSavedLocation
        // When
        let savedLocations = locationsDefaults.value
        // Then
        XCTAssertNotNil(savedLocations)
        XCTAssertEqual(savedLocations!, singleUserSavedLocation)
    }
}
