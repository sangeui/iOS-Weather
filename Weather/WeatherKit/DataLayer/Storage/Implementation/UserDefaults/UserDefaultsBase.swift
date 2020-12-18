//
//  UserDefaultsBase.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/18.
//

import Foundation

protocol UserDefaultsBase {
    var key: Key { get set }
    var defaults: UserDefaults { get set }
    
    func getDataFromDefaults(with key: Key) -> Data?
    func getValueFromData<T: Decodable>(_ data: Data) -> T?
}
extension UserDefaultsBase {
    var encoder: PropertyListEncoder { return PropertyListEncoder() }
    var decoder: PropertyListDecoder { return PropertyListDecoder() }
    var standard: UserDefaults { return UserDefaults.standard }
}
extension UserDefaultsBase {
    func getDataFromDefaults(with key: Key) -> Data? {
        return defaults.value(forKey: key.rawValue) as? Data
    }
    func getValueFromData<T: Decodable>(_ data: Data) -> T? {
        return try? decoder.decode(T.self, from: data)
    }
}
