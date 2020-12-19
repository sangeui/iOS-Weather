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
