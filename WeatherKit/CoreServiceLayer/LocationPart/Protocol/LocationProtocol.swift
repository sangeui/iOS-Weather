//
//  Location.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import CoreLocation

typealias LocationHandler = ((Result<Coordinate, LocationError>) -> Void)

protocol LocationProtocol {
    func getLocation(completion: @escaping LocationHandler)
}

protocol LocationManager {
    // CLLocationManager Properties
    var location: CLLocation? { get }
    var delegate: CLLocationManagerDelegate? { get set }
    
    // CLLocationManager Methods
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
    
    // Wrappers for CLLocationManager class functions.
    func getAuthorizationStatus() -> CLAuthorizationStatus
    func isLocationServicesEnabled() -> Bool
}
extension CLLocationManager: LocationManager {
    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return self.authorizationStatus
    }
}

class MockLocationManager: LocationManager {
    var location: CLLocation? = CLLocation(
        latitude: 37.3317,
        longitude: -122.0325086)
    
    var delegate: CLLocationManagerDelegate?
    
    func requestWhenInUseAuthorization() { }
    func startUpdatingLocation() { }
    func stopUpdatingLocation() { }
    
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return .authorizedWhenInUse
    }
    func isLocationServicesEnabled() -> Bool {
        return true
    }
}
