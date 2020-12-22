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
            guard let strongSelf = self else { return }
            if let error = error { completion(.failure(error)) }
            guard let data = data else { print("DATA WAS NOT FOUNDED"); return }
            do {
                let decoded = try strongSelf.jsonCamelDecoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
