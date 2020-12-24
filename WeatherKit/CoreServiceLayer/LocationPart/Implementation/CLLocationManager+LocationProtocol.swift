//
//  CLLocationManager+LocationProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import CoreLocation

class LocationManager: NSObject {
    private var locationManager: CLLocationManager
    private var completion: LocationHandler?
    
    init(manager: CLLocationManager) {
        self.locationManager = manager
    }
    func getLocation(completion: @escaping LocationHandler) {
        self.completion = completion
        locationManager.requestLocation()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined: break
        case .restricted: break
        case .denied: break
        case .authorizedAlways: break
        case .authorizedWhenInUse: break
        @unknown default: break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let completion = self.completion else { return }
        guard let location = locations.first else { return }
        completion(.success(Coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)))
    }
}
