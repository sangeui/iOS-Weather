//
//  CLLocationManager+LocationProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import CoreLocation

public class LocationManager: NSObject {
    private var locationManager: CLLocationManager
    private var completion: LocationHandler?
    
    public init(manager: CLLocationManager) {
        self.locationManager = manager
        super.init()
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    func getLocation(completion: @escaping LocationHandler) {
        print("⚠️ 사용자 위치를 불러옵니다")
        self.completion = completion
        locationManager.startUpdatingLocation()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined: break
        case .restricted: break
        case .denied: break
        case .authorizedAlways: break
        case .authorizedWhenInUse: locationManager.requestLocation()
        @unknown default: break
        }
    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let completion = self.completion else { return }
        guard let location = locations.first else { return }
        let coordinate = Coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print("✅ 사용자 위치를 가져왔습니다 \(coordinate)")
        completion(.success(coordinate))
        manager.stopUpdatingLocation()
        self.completion = nil
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
