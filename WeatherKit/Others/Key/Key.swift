//
//  UserDefaultsKey.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public struct Key: RawRepresentable {
    public var rawValue: String
    public init?(rawValue: String) { self.rawValue = rawValue }
}
