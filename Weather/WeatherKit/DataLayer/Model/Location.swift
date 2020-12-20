//
//  WeatherCoordination.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation
typealias Latitude = String
typealias Longitude = String
typealias Place = String
typealias TimeStamp = String

public struct Coordination: Codable {
    var latitude: Latitude
    var longitude: Longitude
}
public struct Location: Codable {
    var coordination: Coordination
    var name: Place
}
public struct IdentifiableLocation: Codable {
    var location: Location
    var timestamp: TimeStamp
}
public struct LocationInformation: Codable {
    var location: IdentifiableLocation
    var metadata: LocationMetaData
}
public struct WeatherInformation: Codable {
    var weather: WeatherModel.Data
    var location: LocationInformation
}
