//
//  ContainerViewModel.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation

public class ContainerViewModel: WeatherProvider {
    public var view: Box<WeatherView> = Box(.simple)
    private let persistentManager: PersistentProtocol
    
    public var weathers: Box<[WeatherInformation]> = Box([])
    
    init(_ persistent: PersistentProtocol) {
        self.persistentManager = persistent
    }
    
    public func update(_ weathers: [WeatherInformation]) {
        self.weathers.value = weathers
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

final public class Box<T> {
    var listener: ((T) -> Void)?
    var value: T { didSet { listener?(value) } }
    
    init(_ value: T) { self.value = value }
    
    public func bind(listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(value)
    }
}
