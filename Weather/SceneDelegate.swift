//
//  SceneDelegate.swift
//  Weather
//
//  Created by 서상의 on 2020/12/21.
//

import UIKit
import CoreLocation
import WeatheriOS
import WeatherKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let dependencyContainer = WeatherDependencyContainer()

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = dependencyContainer.makeContainerViewController()
        window?.makeKeyAndVisible()
    }
}

