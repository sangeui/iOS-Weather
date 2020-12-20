//
//  Storage.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/17.
//

import Foundation

protocol Storage {
    func save(_ data: Storable.Save)
    func load(_ type: Storable.Load) -> Any?
    func delete(_ data: Storable.Delete) -> Bool
}
enum Storable {
    enum Delete { case location(TimeStamp) }
    enum Load { case unit, locations }
    enum Save {
        case unit(TemperatureUnit)
        case location(Location)
    }
}
