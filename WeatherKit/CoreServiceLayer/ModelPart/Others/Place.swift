//
//  Place.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public typealias Name = String

public struct Place: Codable {
    public var coordination: Coordinate
    public var name: Name
}

extension Place: Equatable {}
