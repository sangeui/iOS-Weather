//
//  URLSession+NetworkSession.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/19.
//

import Foundation

extension URLSession: NetworkSession {
    func execute<T>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let task = dataTask(with: url) { (data, response, error) in
            if let error = error { completion(.failure(error)); return }
            guard let data = data 
        }
    }
}
