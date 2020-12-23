//
//  UniquePlace+RandomCoord.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/24.
//

@testable import WeatherKit

extension UniquePlace {
    static var randomCoordinate: Coordinate {
        let latitude = Double.random(in: -90...90)
        let longitude = Double.random(in: -180...180)
        return Coordinate(latitude: latitude, longitude: longitude)
    }
    static var randomPlace: Place {
        let words = ["A", "B", "C", "D", "E", "F", "G"]
        return Place(coordination: randomCoordinate, name: words.randomElement()!)
    }
}
