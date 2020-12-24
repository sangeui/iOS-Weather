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
    let sharedWeatherProvider: WeatherProvider
    
    let sharedPersistent: PersistentProtocol
    
    public init() {
        func makePersistent() -> PersistentProtocol {
            let unitDefaults = UnitDefaults()
            let placeDefaults = PlaceDefaults()
            
            let persistent = PersistentUserDefaults(unitDefaults, placeDefaults)
            
            return persistent
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
        func makeContainerViewModel() -> ContainerViewModel {
            let viewModel = ContainerViewModel()
            return viewModel
        }
        func makeWeatherProvider() -> WeatherProvider {
            let networkManager = makeNetworkManager()
            let locationManager = makeLocationManager()
            let persistent = makePersistent()
            let provider = Weathers(networkManager, persistent, locationManager)
            return provider
        }
        
        sharedWeatherProvider = makeWeatherProvider()
        sharedContainerViewModel = makeContainerViewModel()
    }
}
