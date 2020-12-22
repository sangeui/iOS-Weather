//
//  URLSessionDataTask.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/22.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
