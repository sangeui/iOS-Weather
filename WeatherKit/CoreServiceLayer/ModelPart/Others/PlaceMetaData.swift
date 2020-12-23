//
//  PlaceMetaData.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public enum PlaceMetaData: String, Codable {
    case user, custom
}

extension PlaceMetaData: Equatable {}
