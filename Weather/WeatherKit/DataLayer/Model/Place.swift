//
//  WeatherCoordination.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation
typealias Latitude = Double
typealias Longitude = Double
typealias PlaceName = String
typealias TimeStamp = String

public struct Coordination: Codable {
    var latitude: Latitude
    var longitude: Longitude
}
public struct Place: Codable {
    var coordination: Coordination
    var name: PlaceName
}
public struct IdentifiablePlace: Codable {
    var location: Place
    var timestamp: TimeStamp
}
public struct PlaceInformation: Codable {
    var location: IdentifiablePlace
    var metadata: LocationMetaData
}
public struct WeatherInformation: Codable {
    var weather: WeatherModel.Data
    var location: PlaceInformation
}
