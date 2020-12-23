//
//  Place.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

typealias Name = String

public struct Place: Codable {
    var coordination: Coordination
    var name: Name
}

extension Place: Equatable {}
