//
//  UserLocationTests.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/20.
//

import XCTest
@testable import WeatherKit

class UserLocationTests: XCTestCase {
    var userLocationManager: UserLocationManager!
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testUserLocationManagerIsInitiated() {
        XCTAssertNotNil(userLocationManager)
    }
}
