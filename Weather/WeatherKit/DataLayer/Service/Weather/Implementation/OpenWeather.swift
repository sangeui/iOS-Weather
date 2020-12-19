//
//  OpenWeather.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/08.
//

import Foundation

class OpenWeather: WeatherProvider {
    ///
    let queryBuilder: QueryBuilder
    
    /// Protocol `Networking` 구현체
    let networking: NetworkSession
    
    /// 파라미터를 제외한 API 호출 엔드포인트를 유지
    let endPoint: String = "https://api.openweathermap.org/data/2.5/"
    
    /// 날씨 정보를 요청할 수 있는 가능한 모든 옵션
    private let options: Set<String> = ["current", "minutely", "houly", "daily"]
    
    ///
    private let key = APIKey.openWeatherMap
    
    init(queryBuilder: QueryBuilder, networking: NetworkSession) {
        self.queryBuilder = queryBuilder
        self.networking = networking
    }
    
    /// 날씨 정보 요청
    /// - Parameters:
    ///   - coordination: 날씨 정보를 요청하고자 하는 위치의 좌표
    ///   - options: 날씨 정보에 포함될 항목을 지정
    ///   - completion: 성공시에만 `WeatherModel.Data`를 `.success`에 담아 전달함.
    func weather(coordination: Location,
                 options: [ForecastOption],
                 _ completion: @escaping WeatherHandler) {
        let query = makeQuery(with: coordination, options: options)
        let urlString = endPoint + query
        if let url = URL(string: urlString) {
            networking.execute(url, completion: completion)
        } else {
            let error = NetworkingErrorType.url.make("PASSED INVALID URL")
            completion(.failure(error))
        }
    }
}
private extension OpenWeather {
    func makeQuery(with coord: Location, options: [ForecastOption]) -> String {
        let include = Set(options.compactMap({$0.rawValue}))
        let exclude = self.options.subtracting(include)
        return Query.OneCall()
            .latitude(coord.latitude)
            .longitude(coord.longitude)
            .exclude(exclude.joined(separator: ","))
            .appid(key)
            .build()
    }
}
