//
//  UnitDefaults.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/17.
//

import Foundation

struct UnitDefaults: UserDefaultsBase {
    var key: Key
    var defaults: UserDefaults
    
    var value: TemperatureUnit? {
        get {
            guard let data = defaults.string(forKey: key.rawValue) else { return nil }
            return TemperatureUnit(rawValue: data)
        }
        set {
            guard let value = newValue else { return }
            defaults.setValue(value, forKey: key.rawValue)
        }
    }
}
