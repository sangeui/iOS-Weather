//
//  Operator+Save.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

extension Persistent.Operator {
    enum Save {
        case unit(TemperatureUnit)
        case place(Place)
    }
}
