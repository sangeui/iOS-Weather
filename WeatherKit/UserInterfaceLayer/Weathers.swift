//
//  Weathers.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation

public protocol WeatherProvider {
    var weathers: Box<[WeatherInformation]> { get set }
    func update(_ weathers: [WeatherInformation])
}
