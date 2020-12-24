//
//  ContainerViewModel.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation

public class ContainerViewModel {
    public var view: Box<WeatherView> = Box(.simple)
    private let persistentManager: PersistentProtocol
    private var weathers: [WeatherInformation] = []
    
    init(_ persistent: PersistentProtocol) {
        self.persistentManager = persistent
    }
}
extension ContainerViewModel: FullWeatherResponder {
    func requestFullWeatherView(_ index: Int) {
        self.view.value = .full(index)
    }
}
extension ContainerViewModel: SimpleWeatherResponder {
    func reqeustSimpleWeatherView() {
        self.view.value = .simple
    }
}
extension ContainerViewModel: Weathers {
    func update(_ weathers: [WeatherInformation]) {
        self.weathers = weathers
    }
}

final public class Box<T> {
    var listener: ((T) -> Void)?
    var value: T { didSet { listener?(value) } }
    
    init(_ value: T) { self.value = value }
    
    func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
