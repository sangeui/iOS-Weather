//
//  ContainerViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherKit

class ContainerViewController: UIViewController {
    let containerViewModel: ContainerViewModel
    let fullWeatherViewController: FullWeatherViewController
    let simpleWeatherViewController: SimpleWeatherViewController
    
    init(containerViewModel: ContainerViewModel,
         fullWeatherViewController: FullWeatherViewController,
         simpleWeatherViewController: SimpleWeatherViewController) {
        self.containerViewModel = containerViewModel
        self.fullWeatherViewController = fullWeatherViewController
        self.simpleWeatherViewController = simpleWeatherViewController
    }
    
    func listenViewState() {
        
    }
}
