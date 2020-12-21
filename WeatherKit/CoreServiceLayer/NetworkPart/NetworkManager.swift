//
//  NetworkManager.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

class NetworkManager {
    private let network: NetworkProtocol
    private let weather: WeatherProtocol
    
    init(network: NetworkProtocol, weather: WeatherProtocol) {
        self.network = network
        self.weather = weather
    }
    
    func weather(coordination: Coordination, options: [Weather.Option.Forecast], completion: @escaping Weather.Completion) {
        guard let url = url(coordination, options) else { return }
        execute(url, completion: completion)
    }
}
private extension NetworkManager {
    func execute(_ url: URL, completion: @escaping Weather.Completion) {
        network.execute(url, completion: completion)
    }
    func url(_ coordination: Coordination, _ options: [Weather.Option.Forecast]) -> URL? {
        return weather.makeURL(with: coordination, options: options)
    }
}