//
//  WeatherProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public protocol WeatherProtocol {
    var apiKey: String? { get }
    var endPoint: String { get }
    
    func makeURL(with coordination: Coordinate, options: [Weather.Option.Forecast]) -> URL?
}
public extension Weather {
    enum Option {}
}
public extension Weather {
    typealias Completion = ((Result<Weather.Information, Error>) -> Void)
}
public extension Weather.Option {
    enum Forecast: String {
        case current, minutely, hourly, daily
    }
}
extension Weather.Option.Forecast: CaseIterable {
    public static var allCases: [Weather.Option.Forecast] { return [.current, .minutely, .hourly, .daily] }
}
public extension Weather {
    enum EndPoint {}
}
public extension Weather.EndPoint {
    enum OpenWeatherMap {
        case onecall
        
        var base: String {
            switch self {
            case .onecall: return "https://api.openweathermap.org/data/2.5/"
            }
        }
    }
}
