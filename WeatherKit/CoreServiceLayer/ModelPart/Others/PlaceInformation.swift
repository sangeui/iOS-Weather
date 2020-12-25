//
//  PlaceInformation.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public struct PlaceInformation: Codable {
    public var uniquePlace: UniquePlace
    public var metadata: PlaceMetaData
}

extension PlaceInformation: Equatable {}
