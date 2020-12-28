//
//  WeatherToolsViewModel.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/25.
//

import Foundation

public class WeatherToolViewModel {
    var persistent: PersistentProtocol
    var searchResponder: SearchResponder
    
    public init(persistent: PersistentProtocol,
                searchResponder: SearchResponder) {
        self.persistent = persistent
        self.searchResponder = searchResponder
    }
    public func search() {
        self.searchResponder.openSearchView()
    }
}
