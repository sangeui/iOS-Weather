//
//  WeatherProvider.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/08.
//

import Foundation
typealias WeatherHandler = (Result<Weather, Error>) -> Void
protocol EndPointable{
    var endPoint: URL { get }
}
protocol WeatherProvider {
    var endPoint: String { get }
    func weather(coordination: Coordination,
                 options: [ForecastOption],
                 _ completion: @escaping WeatherHandler)
}
enum ForecastOption: String {
    case current, minutely, houly, daily
}
enum Weather {}
enum WeatherModel {
    struct Entire {
        var current: Current?
        var minutely: Minutely?
        var houly: Houly?
        var daily: Daily?
    }
    struct Current {}
    struct Minutely {}
    struct Houly {}
    struct Daily {}
}
struct Coordination {
    var latitude: String, longitude: String
}
protocol Networking {
    func execute<T: Decodable>(_ url: String, completion: )
}
