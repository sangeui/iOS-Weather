//
//  WeatherProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

protocol WeatherProtocol {
    var apiKey: String? { get }
    var endPoint: String { get }
    
    func makeURL(with coordination: Coordination, options: [Weather.Option.Forecast]) -> URL?
}
extension Weather {
    enum Option {}
}
extension Weather {
    typealias Completion = ((Result<Weather.Information, Error>) -> Void)
}
extension Weather.Option {
    enum Forecast: String {
        case current, minutely, hourly, daily
    }
}
extension Weather.Option.Forecast: CaseIterable {
    static var allCases: [Weather.Option.Forecast] { return [.current, .minutely, .hourly, .daily] }
}
extension Weather {
    enum EndPoint {}
}
extension Weather.EndPoint {
    enum OpenWeatherMap {
        case onecall
        
        var base: String {
            switch self {
            case .onecall: return "https://api.openweathermap.org/data/2.5/"
            }
        }
    }
}
