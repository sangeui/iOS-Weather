//
//  URLSessionMock.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/22.
//

import Foundation

class URLSessionMock: URLSession {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    init(data: Data? = nil,
         response: URLResponse? = nil,
         error: Error? = nil) {
        self.data = data
        self.urlResponse = response
        self.error = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.urlResponse
        let error = self.error
        return URLSessionDataTaskMock { completionHandler(data, response, error) }
    }
}
