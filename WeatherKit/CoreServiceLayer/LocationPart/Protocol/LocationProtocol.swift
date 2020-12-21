//
//  Location.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

typealias LocationHandler = ((Result<Coordination, LocationError>) -> Void)

protocol LocationProtocol {
    func getLocation(type: LocationRequestType, completion: @escaping LocationHandler)
}
