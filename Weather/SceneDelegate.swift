//
//  SceneDelegate.swift
//  Weather
//
//  Created by 서상의 on 2020/12/21.
//

import UIKit
import CoreLocation
import WeatherKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        let network = NetworkManager(network: URLSession.shared, weather: OpenWeatherMapOneCall())
        
        let unitDefaults = UnitDefaults()
        let placeDefaults = PlaceDefaults()
        let persistent = PersistentUserDefaults(unitDefaults, placeDefaults)
        let location = LocationManager(manager: CLLocationManager())
        let provider = Weathers(network, persistent, location)
        provider.getUserWeather()
        provider.weathers.bind { (information) in
            print(information)
        }
    
    }
}

