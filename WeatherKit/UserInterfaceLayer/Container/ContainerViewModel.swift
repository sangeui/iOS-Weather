//
//  ContainerViewModel.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation

public class ContainerViewModel {
    private var view: WeatherView = .simple
    private let persistentManager: PersistentProtocol
    private var weathers: [WeatherInformation] = []
    
    init(_ persistent: PersistentProtocol) {
        self.persistentManager = persistent
    }
}
extension ContainerViewModel: FullWeatherResponder {
    public func requestFullWeatherView(_ index: Int) {
        self.view = .full(index)
    }
}
extension ContainerViewModel: SimpleWeatherResponder {
    public func reqeustSimpleWeatherView() {
        self.view = .simple
    }
}
extension ContainerViewModel: Weathers {
    func update(_ weathers: [WeatherInformation]) {
        self.weathers = weathers
    }
}
