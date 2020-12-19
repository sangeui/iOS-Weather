//
//  URLSession+NetworkSession.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/19.
//

import Foundation
extension URLSession: NetworkSession {
    func execute<T>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let task = dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard let weakSelf = self else { return }
            if let error = error { completion(.failure(error)) }
            guard let data = data else { return }
            guard let decoded = weakSelf.json(T.self, from: data) else { return }
            completion(.success(decoded))
        })
        task.resume()
    }
    private func json<T: Decodable>(_ type: T.Type, from data: JSONDecoder.Input) -> T? {
        return try? jsonCamelDecoder.decode(type.self, from: data)
    }
}
