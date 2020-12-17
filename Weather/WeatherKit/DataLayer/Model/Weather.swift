//
//  Weather.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

enum WeatherModel {
    struct Data: Codable {
        var lat: Double
        var lon: Double
        var timezone: String
        var timezone_offset: Double
        
        var current: Current?
        var minutely: Minutely?
        var hourly: Hourly?
        var daily: Daily?
    }
    struct Current: Codable {
        var dt: Double
        var sunrise: Double
        var sunset: Double
        var temp: Double
        var feelsLike: Double
        var pressure: Double
        var humidity: Double
        var dewPoint: Double
        var clouds: Double
        var uvi: Double
        var visibility: Double
        var windSpeed: Double
        var windGust: Double?
        var windDeg: Double
        var rain: Rain
    }
    struct Minutely: Codable {}
    struct Hourly: Codable {}
    struct Daily: Codable {}
    struct Snow: Codable {
        var onehour: Double
        enum CodingKeys: String, CodingKey {
            case onehour = "1h"
        }
    }
    struct Rain: Codable {
        var onehour: Double
        enum CodingKeys: String, CodingKey {
            case onehour = "1h"
        }
    }
}
