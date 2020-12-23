//
//  LocationProtocolMock.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation
import CoreLocation

class LocationProtocolMock: LocationProtocol {
    var location: CLLocation?
    
    init(fakeLocation: CLLocation? = nil) {
        location = fakeLocation
    }
    func getLocation(completion: @escaping LocationHandler) {
        guard let location = location else {
            completion(.failure(.locationNotFound))
            return
        }
        let coordinate = Coordinate(latitude: location.latitude,
                                    longitude: location.longitude)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(.success(coordinate))
        }
    }
}
fileprivate extension CLLocation {
    var latitude: CLLocationDegrees { return self.coordinate.latitude }
    var longitude: CLLocationDegrees { return self.coordinate.longitude }
}
