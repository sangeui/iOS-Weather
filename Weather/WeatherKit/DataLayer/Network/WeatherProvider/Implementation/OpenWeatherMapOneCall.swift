//
//  OpenWeatherMapOneCall.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/19.
//

import Foundation

struct OpenWeatherMapOneCall: WeatherProvider {
    var endPoint: String = "https://api.openweathermap.org/data/2.5/"
    var apiKey: String? = APIKey.openWeatherMap
    var queryBuilder = Query.OneCall()
    
    func makeURL(with location: Location, options: [ForecastOption]) -> URL? {
        return URL(string: endPoint + makeQuery(with: location, options: options))
    }
    /// 날씨 정보를 요청할 수 있는 가능한 모든 옵션
    private let options: Set<String> = ["current", "minutely", "houly", "daily"]
    
    private func makeQuery(with location: Location, options: [ForecastOption]) -> String {
        let include = Set(options.compactMap({$0.rawValue}))
        let exclude = self.options.subtracting(include)
        return queryBuilder
            .latitude(location.latitude)
            .longitude(location.longitude)
            .exclude(exclude.joined(separator: ","))
            .appid(apiKey!)
            .build()
    }
}
