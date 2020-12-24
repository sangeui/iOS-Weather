//
//  Network+Completion.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

extension Network {
    public typealias Completion<T: Decodable> = (Result<T, Error>) -> Void
}
