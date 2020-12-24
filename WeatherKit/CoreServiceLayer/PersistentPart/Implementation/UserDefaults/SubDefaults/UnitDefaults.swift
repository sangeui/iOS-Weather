//
//  UnitDefaults.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public struct UnitDefaults: UserDefaultsProtocol {
    var key: Key
    var defaults: UserDefaults
    
    public init(key: Key = Key.place, defaults: UserDefaults = .standard) {
        self.key = key
        self.defaults = defaults
    }
    
    var value: TemperatureUnit? {
        get { getUnit() }
        set { setUnit(newValue) }
    }
}
private extension UnitDefaults {
    func getUnit() -> TemperatureUnit? {
        guard let string = loadString(with: key) else { return nil }
        return TemperatureUnit(rawValue: string)
    }
    func setUnit(_ unit: TemperatureUnit?) {
        guard let newUnit = unit else { return }
        saveValue(newUnit.rawValue, with: key)
    }
}
