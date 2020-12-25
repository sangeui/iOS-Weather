//
//  WeatherListDependencyContainer.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/25.
//

import Foundation
import WeatherKit

class WeatherListDependencyContainer {
    var weatherDependencyContainer: WeatherDependencyContainer
    
    init(weatherDependencyContainer: WeatherDependencyContainer) {
        self.weatherDependencyContainer = weatherDependencyContainer
    }
    
    func makeWeatherListViewController() -> WeatherSimpleViewController {
        let simpleViewModel = makeWeatherSimpleViewModel()
        let listViewModel = makeWeatherListViewModel()
        let toolsViewModel = makeToolsViewModel()
        
        return WeatherSimpleViewController(simpleViewModel: simpleViewModel, listViewModel: listViewModel, toolsViewModel: toolsViewModel)
    }
    func makeWeatherSimpleViewModel() -> WeatherSimpleViewModel {
        return WeatherSimpleViewModel()
    }
    func makeWeatherListViewModel() -> WeatherListViewModel {
        let provider = weatherDependencyContainer.sharedWeatherProvider!
        let responder = weatherDependencyContainer.sharedContainerViewModel
        return WeatherListViewModel(weatherProvider: provider, fullWeatherResponder: responder)
    }
    func makeToolsViewModel() -> WeatherToolsViewModel {
        let persistent = weatherDependencyContainer.sharedPersistent
        return WeatherToolsViewModel(persistent: persistent)
    }
}
