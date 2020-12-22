//
//  NetworkProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

protocol NetworkProtocol {
    func execute<T: Decodable>(_ url: URL, completion: @escaping Network.Completion<T>)
}
extension NetworkProtocol {
    var jsonEncoder: JSONEncoder { return JSONEncoder() }
    var jsonDecoder: JSONDecoder { return JSONDecoder() }
    var jsonCamelDecoder: JSONDecoder { return JSONDecoder(with: .convertFromSnakeCase) }
}
extension JSONDecoder {
    convenience init(with strategy: KeyDecodingStrategy) {
        self.init()
        keyDecodingStrategy = strategy
    }
}
