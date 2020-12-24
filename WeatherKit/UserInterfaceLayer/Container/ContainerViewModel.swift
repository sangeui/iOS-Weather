//
//  ContainerViewModel.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation

public class ContainerViewModel {
    public var view: Box<WeatherView> = Box(.simple)
    
    public init() {}
}
extension ContainerViewModel: FullWeatherResponder {
    public func requestFullWeatherView(_ index: Int) {
        self.view.value = .full(index)
    }
}
extension ContainerViewModel: SimpleWeatherResponder {
    public func reqeustSimpleWeatherView() {
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
