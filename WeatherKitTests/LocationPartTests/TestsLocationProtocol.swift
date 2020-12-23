//
//  TestsLocationProtocol.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/24.
//

import XCTest
@testable import WeatherKit
import CoreLocation

class TestsLocationProtocol: XCTestCase {
    var locationManager: LocationProtocol?
    
    override func tearDown() {
        locationManager = nil
    }
    func makeLocationManager(with location: CLLocation? = nil) {
        locationManager = LocationProtocolMock(fakeLocation: location)
    }
    func prepareLocationManagerWithLocation() {
        let coordinate = UniquePlace.randomCoordinate
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        makeLocationManager(with: location)
    }
    func prepareLocationManager() {
        makeLocationManager()
    }
    func testGetLocation() {
        let exp = expectation(description: "LocationProtocol")
        
        prepareLocationManagerWithLocation()
        
        locationManager?.getLocation(completion: { result in
            switch result {
            case .success(let coordinate): print(coordinate)
            default: break
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
    func testFailedGetLocation() {
        let exp = expectation(description: "LocationProtocol")
        prepareLocationManager()
        
        locationManager?.getLocation(completion: { result in
            switch result {
            case .success(_): break
            case .failure(let error):
                XCTAssertEqual(error, .locationNotFound)
            }
            exp.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
    }
}
