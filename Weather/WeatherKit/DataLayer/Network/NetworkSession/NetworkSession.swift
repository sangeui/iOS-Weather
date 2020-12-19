//
//  Networking.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

typealias NetworkCompletion<T: Decodable> = (Result<T, Error>) -> Void

protocol NetworkSession {
    func execute<T: Decodable>(_ url: URL, completion: @escaping NetworkCompletion<T>)
}
extension NetworkSession {
    var jsonEncoder: JSONEncoder { return JSONEncoder() }
    var jsonDecoder: JSONDecoder { return JSONDecoder() }
    
    var jsonCamelDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
