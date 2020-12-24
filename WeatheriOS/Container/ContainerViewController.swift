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
    
    init(containerViewModel: ContainerViewModel,
         pageViewController: PageViewController,
         simpleWeatherViewController: SimpleWeatherViewController) {
        self.containerViewModel = containerViewModel
        self.pageViewController = pageViewController
        self.simpleWeatherViewController = simpleWeatherViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        }
    }
}
