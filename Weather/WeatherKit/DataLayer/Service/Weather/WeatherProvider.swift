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
    var endPoint: String { get }
    var apiKey: String? { get }
}
