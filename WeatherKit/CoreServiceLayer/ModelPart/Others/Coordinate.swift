//
//  Coordination.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

typealias Latitude = Double
typealias Longitude = Double

public struct Coordinate: Codable {
    var latitude: Latitude
    var longitude: Longitude
}

extension Coordinate: Equatable {}
