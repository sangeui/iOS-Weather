//
//  ContainerViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherUIKit
import WeatherKit

class ContainerViewController: ViewController {
    let containerViewModel: ContainerViewModel
    let pageViewController: PageViewController
    let simpleWeatherViewController: SimpleWeatherViewController
    let initialViewController: InitialViewController
    
    init(containerViewModel: ContainerViewModel,
         initialViewController: InitialViewController,
         pageViewController: PageViewController,
         simpleWeatherViewController: SimpleWeatherViewController) {
        self.containerViewModel = containerViewModel
        self.initialViewController = initialViewController
        self.pageViewController = pageViewController
        self.simpleWeatherViewController = simpleWeatherViewController
        
        super.init()
        listenViewState()
    }
    
    func listenViewState() {
        containerViewModel.view.bind(listener: move(to:))
    }
    func move(to view: WeatherView) {
        switch view {
        case .simple:
            self.present(simpleWeatherViewController, animated: true, completion: nil)
        case .full(_):
            self.present(pageViewController, animated: true, completion: nil)
        case .initial:
            self.present(initialViewController, animated: true, completion: nil)
        }
    }
}
