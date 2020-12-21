//
//  UserDefaultsProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

protocol UserDefaultsProtocol {
    var key: Key { get set }
    var defaults: UserDefaults { get set }
}
extension UserDefaultsProtocol {
    var propertyEncoder: PropertyListEncoder { return PropertyListEncoder() }
    var propertyDecoder: PropertyListDecoder { return PropertyListDecoder() }
    func loadData(with key: Key) -> Data? {
        return defaults.value(forKey: key.rawValue) as? Data
    }
    /// `Data`가 주어졌을 때, 이를 제네릭 T 타입으로 변환하여 반환한다.
    /// - Parameter data: 변환할 `Data` 타입의 데이터
    /// - Returns: `Decodable` 프로토콜을 따르는 T 타입의 데이터
    func loadValue<T: Decodable>(_ data: Data) -> T? {
        return try? propertyDecoder.decode(T.self, from: data)
    }
    func loadString(with key: Key) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    func encodeValue<T: Encodable>(_ value: T) -> Data? {
        return try? propertyEncoder.encode(value)
    }
    func saveData(with key: Key, data: Data) {
        defaults.setValue(data, forKey: key.rawValue)
    }
    func saveValue(_ value: Any?, with key: Key) {
        defaults.setValue(value, forKey: key.rawValue)
    }
}
