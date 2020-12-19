//
//  WeatherProvider.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/08.
//

import Foundation
typealias WeatherHandler = (Result<WeatherModel.Data, Error>) -> Void
protocol EndPointable{
    var endPoint: URL { get }
}
protocol WeatherProvider {
    var apiKey: String? { get }
    var endPoint: String { get }
    
    /// 적당한 인자를 전달해 완성된 URL을 돌려 받는다.
    /// - Parameters:
    ///   - coord: `Location` 타입의 좌표 정보
    ///   - options: 요청하고자 하는 예보 옵션을 배열 타입으로 전달
    func makeURL(with location: Location, options: [ForecastOption]) -> URL?
}
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
