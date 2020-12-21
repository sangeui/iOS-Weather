//
//  UserLocationManager.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/20.
//

import Foundation
enum UserLocationRequestType {
    case once, tracking
}
typealias UserLocationManagerHandler = (Result<Coordination, Error>) -> Void
protocol LocationManagerProtocol {
    func getUserLocation(type: UserLocationRequestType, completion: @escaping UserLocationManagerHandler)
}
