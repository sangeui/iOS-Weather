//
//  FakeUserDefaults.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/23.
//

import Foundation
@testable import WeatherKit

struct UnitTestDefaults {
    static func make() -> UserDefaults? {
        return UserDefaults(suiteName: "UnitTest")
    }
    static func clear() {
        UserDefaults().removePersistentDomain(forName: "UnitTest")
    }
}
