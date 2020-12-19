//
//  WeatherNetworking.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

class WeatherNetworking: NetworkSession {
    
    func execute<T>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error { completion(.failure(error)); return }
                guard let data = data
                else { completion(.failure(self._error(type: .data, ""))); return }
                let decoder = JSONDecoder(true)
                let decoded = try decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch { completion(.failure(error)) }
        }.resume()
    }
}
extension WeatherNetworking {
    func _error(type: NetworkingErrorType, _ message: String) -> NetworkingError {
        return type.make(message)
    }
}
extension JSONDecoder {
    convenience init(_ toCamelCase: Bool) {
        self.init()
        if toCamelCase { keyDecodingStrategy = .convertFromSnakeCase }
    }
}
