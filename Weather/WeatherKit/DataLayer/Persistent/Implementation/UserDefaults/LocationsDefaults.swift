//
//  UnitDefaults.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/17.
//

import Foundation


/// 오직 주어진 UserDefaults 를 통해 value 를 저장하고 가져오는 역할을 함.
/// 기존의 데이터로부터 특정 값을 제거하거나 기존의 데이터에 특정 값을 더하려면, 상위 레이어에서 처리하여 전체 데이터를 전달 받아야 한다.
struct LocationsDefaults: UserDefaultsBase {
    var key: Key
    var defaults: UserDefaults
    
    var value: [IdentifiablePlace]? {
        get {
            guard let data = getDataFromDefaults(with: key) else { return nil }
            guard let value: [IdentifiablePlace] = getValueFromData(data) else { return nil }
            return value
        }
        set {
            guard let data = try? encoder.encode(newValue) else { print(); return }
            defaults.setValue(data, forKey: key.rawValue)
        }
    }
}
