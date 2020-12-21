//
//  UserLocationTests.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/20.
//

import XCTest
@testable import WeatherKit

class UserLocationTests: XCTestCase {
    var locationManager: UserLocation!
    
    override func setUp() {
        locationManager = LocationManagerMock()
    }
    
    override func tearDown() {
    }
    
    func testLocationManagerIsInitiated() {
        XCTAssertNotNil(locationManager)
    }
    func testGetUserLocationOnce() {
        let exp = expectation(description: "Location Test")
        locationManager.getUserLocation(type: .once) { result in
            switch result {
            case .success(let coordination):
                print(coordination)
            case .failure(let error): print(error)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
