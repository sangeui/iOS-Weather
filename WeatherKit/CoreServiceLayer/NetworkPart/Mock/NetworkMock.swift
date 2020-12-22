//
//  NetworkMock.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/22.
//

import Foundation

class NetworkMock: NetworkProtocol {
    var fakeSession: URLSession
    
    init(_ session: URLSession) {
        self.fakeSession = session
    }
    func execute<T>(_ url: URL, completion: @escaping Network.Completion<T>) where T : Decodable {
//        fakeSession.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
    }
}
extension Network {
    enum DataError: Error {
        case invalid
    }
}
