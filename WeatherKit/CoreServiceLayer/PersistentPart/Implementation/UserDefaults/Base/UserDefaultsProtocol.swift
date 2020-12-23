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
    
    func saveValue(_ value: Any?, with key: Key) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    func loadValue(with key: Key) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
    func loadData(with key: Key) -> Data? {
        return defaults.value(forKey: key.rawValue) as? Data
    }
    /// `Key`가 주어졌을 때, 저장된 문자열을 반환한다.
    /// - Parameter key: `Key` 형식
    /// - Returns: 옵셔널 `String` 을반환한다.
    func loadString(with key: Key) -> String? {
        return defaults.string(forKey: key.rawValue)
    }
    
    /// 인코딩된 데이터를 String 형식으로 반환한다.
    /// - Parameters:
    ///   - data: `Data` 형식의 데이터
    ///   - encoding: 사용할 `String.Encoding` 타입
    /// - Returns: 옵셔널 `String` 을 반환한다.
    func loadString(from data: Data, using encoding: String.Encoding) -> String? {
        return String(data: data, encoding: encoding)
    }
    func encodeValue<T: Encodable>(_ value: T) -> Data? {
        return try? propertyEncoder.encode(value)
    }
    /// `Data`가 주어졌을 때, 이를  제네릭 T 타입으로 변환하여 반환한다.
    /// - Parameter data: 변환할 `Data` 타입의 데이터
    /// - Returns: `Decodable` 프로토콜을 따르는 T 타입의 데이터
    func decodeData<T: Decodable>(_ data: Data) -> T? {
        return try? propertyDecoder.decode(T.self, from: data)
    }
}
struct UserDefaultsProtocolMock: UserDefaultsProtocol {
    var key: Key
    var defaults: UserDefaults
}
