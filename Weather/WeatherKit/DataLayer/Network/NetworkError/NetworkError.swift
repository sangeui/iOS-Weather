//
//  NetworkingError.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL(String)
    case invalidData(String)
}
public extension NetworkError {
}
enum NetworkErrorType {
    case url
    case data
}
extension NetworkErrorType {
    func make(_ message: String) -> NetworkError {
        switch self {
        case .url: return NetworkError.invalidURL(message)
        case .data: return NetworkError.invalidData(message)
        }
    }
}
