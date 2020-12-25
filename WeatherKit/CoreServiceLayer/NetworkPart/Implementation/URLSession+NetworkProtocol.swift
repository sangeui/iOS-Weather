//
//  URLSession+NetworkProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/22.
//

import Foundation

extension URLSession: NetworkProtocol {
    public func execute<T>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        print("⚠️ API 호출을 시작합니다.")
        print("▶️ API 호출 주소—\(url.absoluteString)")
        let task = dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            if let error = error { completion(.failure(error)) }
            guard let data = data else { print("⛔️ 데이터를 불러오지 못했습니다."); return }
            do {
                let decoded = try strongSelf.jsonCamelDecoder.decode(T.self, from: data)
                print("✅ API 호출에 성공했습니다.")
                completion(.success(decoded))
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
