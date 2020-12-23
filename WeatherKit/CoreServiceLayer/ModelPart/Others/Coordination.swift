//
//  Coordination.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

typealias Latitude = Double
typealias Longitude = Double

public struct Coordination: Codable {
    var latitude: Latitude
    var longitude: Longitude
}

extension Coordination: Equatable {}
