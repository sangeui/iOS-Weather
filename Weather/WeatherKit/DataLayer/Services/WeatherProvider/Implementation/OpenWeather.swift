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
    let networking: Networking
    
    /// 파라미터를 제외한 API 호출 엔드포인트를 유지
    let endPoint: String = "https://api.openweathermap.org/data/2.5/"
    
    /// 날씨 정보를 요청할 수 있는 가능한 모든 옵션
    private let options: Set<String> = ["current", "minutely", "houly", "daily"]
    
    ///
    private let key = APIKey.openWeatherMap
    
    init(queryBuilder: QueryBuilder, networking: Networking) {
        self.queryBuilder = queryBuilder
        self.networking = networking
    }
    
    /// 날씨 정보 요청
    /// - Parameters:
    ///   - coordination: 날씨 정보를 요청하고자 하는 위치의 좌표
    ///   - options: 날씨 정보에 포함될 항목을 지정
    ///   - completion: <#completion description#>
    func weather(coordination: Coordination,
                 options: [ForecastOption],
                 _ completion: @escaping WeatherHandler) {
        let query = makeQuery(with: coordination, options: options)
        let url = endPoint + query
    }
}
private extension OpenWeather {
    func makeQuery(with coord: Coordination, options: [ForecastOption]) -> String {
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
fileprivate enum Query {
    class OneCall: QueryBuilder {
        var root: String = "onecall"
        var query: String = ""
        
        func latitude(_ latitude: String) -> Self {
            appendParameter("lat=\(latitude)")
            return self
        }
        func longitude(_ longitude: String) -> Self {
            appendParameter("lon=\(longitude)")
            return self
        }
        func exclude(_ exclude: String) -> Self {
            appendParameter("exclude=\(exclude)")
            return self
        }
        func appid(_ appid: String) -> Self {
            appendParameter("appid=\(appid)")
            return self
        }
        func build() -> String {
            defer { query.removeAll() }
            return root+query
        }
        private func appendParameter(_ parameter: String) {
            addAmpersandIfNeeded()
            query.append(parameter)
        }
    }
}
protocol QueryBuilder: class {
    var root: String { get }
    var query: String { get set }
}
extension QueryBuilder {
    func addAmpersandIfNeeded() {
        if !query.isEmpty { query.append("&") }
        else { query.append("?") }
    }
}
