//
//  WeatherDependencyInjectionContainer.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation
import WeatherKit
import CoreLocation

public class WeatherDependencyContainer {
    let sharedContainerViewModel: ContainerViewModel
    var sharedPersistent: PersistentProtocol
    var sharedWeatherProvider: WeatherProvider!
    
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
        let simpleWeatherViewController = makeSimpleWeatherViewController()
        let containerViewController =  ContainerViewController(containerViewModel: sharedContainerViewModel, initialViewController: initialViewController, pageViewController: weatherViewController, simpleWeatherViewController: simpleWeatherViewController)
        
        return containerViewController
    }
    public func makeInitialViewController() -> InitialViewController {
        return InitialViewController(sharedContainerViewModel, sharedContainerViewModel)
    }
    public func makeWeatherViewController() -> WeatherViewController {
        if let weatherProvider = sharedWeatherProvider {
            return WeatherViewController(weatherProvider)
        } else {
            sharedWeatherProvider = makeWeatherProvider()
            return WeatherViewController(sharedWeatherProvider!)
        }
    }
    public func makeSimpleWeatherViewController() -> SimpleWeatherViewController {
        let controller = SimpleWeatherViewController()
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
