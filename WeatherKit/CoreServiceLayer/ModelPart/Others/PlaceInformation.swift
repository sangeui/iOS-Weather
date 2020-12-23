//
//  PlaceInformation.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public struct PlaceInformation: Codable {
    var uniquePlace: UniquePlace
    var metadata: PlaceMetaData
}

extension PlaceInformation: Equatable {}
