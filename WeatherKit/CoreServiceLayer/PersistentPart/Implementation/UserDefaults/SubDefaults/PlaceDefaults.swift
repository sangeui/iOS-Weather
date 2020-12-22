//
//  PlaceDefaults.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

struct PlaceDefaults: UserDefaultsProtocol {
    var key: Key
    var defaults: UserDefaults
    
    init(key: Key = Key.place, defaults: UserDefaults = .standard) {
        self.key = key
        self.defaults = defaults
    }
    
    var value: [UniquePlace]? {
        get { getPlace() }
        set { setPlace(newValue) }
    }
    
}
private extension PlaceDefaults {
    func getPlace() -> [UniquePlace]? {
        guard let data = loadData(with: key) else { return nil }
        guard let value: [UniquePlace] = loadValue(data) else { return nil }
        return value
    }
    func setPlace(_ place: [UniquePlace]?) {
        guard let data = encodeValue(place) else { return }
        saveValue(data, with: key)
    }
}
