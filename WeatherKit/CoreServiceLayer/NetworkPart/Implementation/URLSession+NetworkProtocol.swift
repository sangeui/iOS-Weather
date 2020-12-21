//
//  URLSession+NetworkProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/22.
//

import Foundation

extension URLSession: NetworkProtocol {
    func execute<T>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let task = dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error { completion(.failure(error)) }
            guard let data = data else { return }
            guard let decoded = try? self?.jsonCamelDecoder.decode(T.self, from: data) else { return }
            completion(.success(decoded))
        }
        task.resume()
    }
}
