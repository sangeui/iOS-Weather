//
//  UniquePlace.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public typealias TimeStamp = String

public struct UniquePlace: Codable {
    public var place: Place
    public var timestamp: TimeStamp
}

extension UniquePlace: Equatable {}
