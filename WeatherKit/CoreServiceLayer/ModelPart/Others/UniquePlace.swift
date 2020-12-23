//
//  UniquePlace.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

typealias TimeStamp = String

public struct UniquePlace: Codable {
    var place: Place
    var timestamp: TimeStamp
}

extension UniquePlace: Equatable {}
