//
//  Location.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

typealias LocationHandler = ((Result<Coordinate, LocationError>) -> Void)

protocol LocationProtocol {
    func getLocation(completion: @escaping LocationHandler)
}
