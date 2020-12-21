//
//  UserLocationManager.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/20.
//

import Foundation
enum LocationRequestType {
    case once, tracking
}
typealias LocationHandler = (Result<Coordination, Error>) -> Void
protocol LocationProtocol {
    func getUserLocation(type: LocationRequestType, completion: @escaping LocationHandler)
}
