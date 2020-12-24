//
//  PageViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherUIKit
import WeatherKit

public class WeatherViewController: PageViewController {
    var weatherProvider: WeatherProvider
    
    init(_ weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        super.init()
    }
}
