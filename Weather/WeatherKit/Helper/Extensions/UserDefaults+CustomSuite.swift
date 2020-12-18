//
//  UserDefaults+CustomSuite.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/18.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "Weather")
        return combined
    }
}
