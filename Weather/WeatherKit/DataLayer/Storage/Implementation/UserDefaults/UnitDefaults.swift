//
//  UnitDefaults.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/17.
//

import Foundation

struct UnitDefaults {
    let key: Key
    let defaults: UserDefaults
    
    var value: TemperatureUnit? {
        get {
            guard let data = defaults.string(forKey: key.rawValue) else { return nil }
            return TemperatureUnit(rawValue: data)
        }
        set {
            if let data = newValue as? TemperatureUnit {
                defaults.setValue(data.rawValue, forKey: key.rawValue)
            }
        }
    }
}
