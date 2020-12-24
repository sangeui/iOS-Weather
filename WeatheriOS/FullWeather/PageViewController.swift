//
//  PageViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherKit

class PageViewController: UIPageViewController {
    var weatherProvider: WeatherProvider
    
    init(_ weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
