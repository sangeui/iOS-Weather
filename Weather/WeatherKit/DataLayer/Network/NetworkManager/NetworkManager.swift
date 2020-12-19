//
//  NetworkManager.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/08.
//

import Foundation

class NetworkManager {
    
    private let networking: NetworkSession
    private let provider: WeatherProvider
    
    init(provider: WeatherProvider, networking: NetworkSession = URLSession.shared) {
        self.provider = provider
        self.networking = networking
    }
    
    /// 날씨 정보 요청
    /// - Parameters:
    ///   - coordination: 날씨 정보를 요청하고자 하는 위치의 좌표
    ///   - options: 날씨 정보에 포함될 항목을 지정
    ///   - completion: 성공시에만 `WeatherModel.Data`를 `.success`에 담아 전달함.
    func weather(location: Location,
                 options: [ForecastOption],
                 _ completion: @escaping WeatherHandler) {
        if let url = url(location, options) { networking.execute(url, completion: completion) }
        else { completion(.failure(error(type: .url, "INVALID URL"))) }
    }
}
private extension NetworkManager {
    func execute(_ url: URL, _ completion: @escaping WeatherHandler) {
        networking.execute(url, completion: completion)
    }
    func url(_ location: Location, _ options: [ForecastOption]) -> URL? {
        return provider.makeURL(with: location, options: options)
    }
    func error(type: NetworkErrorType, _ message: String) -> Error {
        return type.make(message)
    }
}
