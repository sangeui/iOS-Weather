//
//  NetworkingError.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

public enum NetworkingError: Error {
    case invalidURL(String)
    case invalidData(String)
}
public extension NetworkingError {
}
enum NetworkingErrorType {
    case url
    case data
}
extension NetworkingErrorType {
    func make(_ message: String) -> NetworkingError {
        switch self {
        case .url: return NetworkingError.invalidURL(message)
        case .data: return NetworkingError.invalidData(message)
        }
    }
}
