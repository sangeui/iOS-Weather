//
//  SimpleWeatherViewController.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation

public class WeatherListViewModel {
    public var weatherProvider: WeatherProvider
    public var fullWeatherResponder: FullWeatherResponder
    
    public init(weatherProvider: WeatherProvider,
         fullWeatherResponder: FullWeatherResponder) {
        self.weatherProvider = weatherProvider
        self.fullWeatherResponder = fullWeatherResponder
    }
}
