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
class NetworkMock: NetworkProtocol {
    var data: Data?
    var error: Error?
    
    func execute<T>(_ url: URL, completion: @escaping Network.Completion<T>) where T : Decodable {
        <#code#>
    }
}
class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
class URLSessionMock: URLSession {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.urlResponse
        let error = self.error
        
        return URLSessionDataTaskMock { completionHandler(data, response, error) }
    }
}
