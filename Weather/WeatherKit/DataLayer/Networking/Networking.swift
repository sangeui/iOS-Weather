//
//  Networking.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

protocol Networking {
    func execute<T: Decodable>(_ url: String, completion: @escaping (Result<T, Error>) -> Void)
}
