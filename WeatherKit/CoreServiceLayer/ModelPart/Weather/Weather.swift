//
//  Weather.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public enum Weather {
    public struct Information: Codable {
        var lat: Double
        var lon: Double
        var timezone: String
        var timezoneOffset: Double
        
        public var current: Current?
        var minutely: [Minutely]?
        var hourly: [Hourly]?
        var daily: [Daily]?
    }
    
    public struct Current: Codable {
        public var dt: Double
    }
    struct Minutely: Codable {}
    struct Hourly: Codable {}
    struct Daily: Codable {}
    
    struct Snow: Codable {}
    struct Rain : Codable {}
}
