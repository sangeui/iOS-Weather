//
//  WeatherDependencyInjectionContainer.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation
import CoreLocation
import WeatherKit

public class WeatherDependencyContainer {
    let sharedContainerViewModel: ContainerViewModel
    public var sharedPersistent: PersistentProtocol
    public var sharedWeatherProvider: WeatherProvider!
    
    public init() {
        func makePersistent() -> PersistentProtocol {
            let unitDefaults = UnitDefaults()
            let placeDefaults = PlaceDefaults()
            
            let persistent = PersistentUserDefaults(unitDefaults, placeDefaults)
            
            return persistent
        }
        func makeContainerViewModel() -> ContainerViewModel {
            let viewModel = ContainerViewModel()
            return viewModel
        }
        
        sharedPersistent = makePersistent()
        sharedContainerViewModel = makeContainerViewModel()
    }
    public func makeContainerViewController() -> ContainerViewController {
        let initialViewController = makeInitialViewController()
        let weatherViewController = makeWeatherViewController()
        let simpleWeatherViewController = makeWeatherListViewController()
        let containerViewController =  ContainerViewController(containerViewModel: sharedContainerViewModel, initialViewController: initialViewController, pageViewController: weatherViewController, simpleWeatherViewController: simpleWeatherViewController)
        
        return containerViewController
    }
    public func makeInitialViewController() -> InitialViewController {
        return InitialViewController(sharedContainerViewModel, sharedContainerViewModel)
    }
    public func makeWeatherViewController() -> WeatherPageViewController {
        if let weatherProvider = sharedWeatherProvider {
            return WeatherPageViewController(weatherProvider)
        } else {
            sharedWeatherProvider = makeWeatherProvider()
            return WeatherPageViewController(sharedWeatherProvider!)
        }
    }
    public func makeWeatherListViewController() -> WeatherSimpleViewController {
        let listDependencyContainer = WeatherListDependencyContainer(weatherDependencyContainer: self)
        let controller = listDependencyContainer.makeWeatherListViewController()
        return controller
    }
    func makeWeatherProvider() -> WeatherProvider {
        let networkManager = makeNetworkManager()
        let locationManager = makeLocationManager()
        let persistent = sharedPersistent
        let provider = Weathers(networkManager, persistent, locationManager)
        return provider
    }
    func makeNetworkManager() -> NetworkManager {
        let network = URLSession.shared
        let weatherAPI = OpenWeatherMapOneCall()
        
        let manager = NetworkManager(network: network, weather: weatherAPI)
        
        return manager
    }
    func makeLocationManager() -> LocationManager {
        let manager = LocationManager(manager: CLLocationManager())
        return manager
    }
}
