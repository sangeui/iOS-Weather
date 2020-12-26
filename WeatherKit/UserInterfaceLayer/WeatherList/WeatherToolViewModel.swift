//
//  WeatherToolsViewModel.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/25.
//

import Foundation

public class WeatherToolViewModel {
    var persistent: PersistentProtocol
    
    public init(persistent: PersistentProtocol) {
        self.persistent = persistent
    }
}
