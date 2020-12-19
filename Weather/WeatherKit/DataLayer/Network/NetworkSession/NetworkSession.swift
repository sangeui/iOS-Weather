//
//  Networking.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

protocol NetworkSession {
    func execute<T: Decodable>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void)
}
