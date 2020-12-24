//
//  PlacesWeatherViewModel.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation

class PlacesWeatherViewModel {
    private let persistentManager: PersistentProtocol
    private let networkManager: NetworkProtocol
    
//    private var view:
    
    init(persistent: PersistentProtocol,
         network: NetworkProtocol) {
        self.persistentManager = persistent
        self.networkManager = network
    }
}
