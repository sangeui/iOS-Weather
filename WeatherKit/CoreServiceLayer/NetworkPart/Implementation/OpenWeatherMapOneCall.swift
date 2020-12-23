//
//  OpenWeatherMapOneCall.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

struct OpenWeatherMapOneCall: WeatherProtocol {
    var apiKey: String? = Key.API
    var endPoint: String = Weather.EndPoint.OpenWeatherMap.onecall.base
    
    func makeURL(with coordination: Coordinate, options: [Weather.Option.Forecast]) -> URL? {
        return URL(string: endPoint + makeQuery(coordination, options))
    }
    private func makeQuery(_ coordination: Coordinate, _ options: [Weather.Option.Forecast]) -> String {
        let all = Set(Weather.Option.Forecast.allCases.map { $0.rawValue })
        let include = Set(options.map({ $0.rawValue }))
        let exclude = all.subtracting(include).joined(separator: ",")
        let queryBuilder = QueryBuilder()
        let queryString = queryBuilder
            .latitude(coordination.latitude)
            .longitude(coordination.longitude)
            .exclude(exclude)
            .appid(apiKey!)
            .build()
        
        return queryString
    }
}
fileprivate typealias Parameter = String
fileprivate typealias APIKey = String

private class QueryBuilder {
    var root = "onecall"
    var queryString = ""
    
    func latitude(_ latitude: Latitude) -> Self {
        appendParameter("lat=\(latitude)")
        return self
    }
    func longitude(_ longitude: Longitude) -> Self {
        appendParameter("lon=\(longitude)")
        return self
    }
    func exclude(_ exclude: String) -> Self {
        appendParameter("exclude=\(exclude)")
        return self
    }
    func appid(_ appid: APIKey) -> Self {
        appendParameter("appid=\(appid)")
        return self
    }
    func build() -> String {
        defer { queryString.removeAll() }
        return root + queryString
    }
}
private extension QueryBuilder {
    func appendParameter(_ parameter: Parameter) {
        appendAmpersandIfNeeded()
        queryString.append(parameter)
    }
    func appendAmpersandIfNeeded() {
        if !queryString.isEmpty { queryString.append("&") }
        else { queryString.append("?") }
    }
}
