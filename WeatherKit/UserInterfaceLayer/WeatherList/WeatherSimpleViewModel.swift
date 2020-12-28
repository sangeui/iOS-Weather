//
//  WeatherSimpleViewModel.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/25.
//

import Foundation

public class WeatherSimpleViewModel {
    public var search: Box<Bool> = Box(false)
    public init() {}
}
extension WeatherSimpleViewModel: SearchResponder {
    public func openSearchView() {
        self.search.value = true
    }
    public func closeSearchView() {
        self.search.value = false
    }
}
