//
//  InitialViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherUIKit
import WeatherKit

class InitialViewController: ViewController {
    var fullWeatherResponder: FullWeatherResponder
    var simpleWeatherResponder: SimpleWeatherResponder
    
    init(_ fullWeatherResponder: FullWeatherResponder,
         _ simpleWeatherResponder: SimpleWeatherResponder) {
        self.fullWeatherResponder = fullWeatherResponder
        self.simpleWeatherResponder = simpleWeatherResponder
        
        super.init()
    }
    
    override func viewDidLoad() {

    }
}

protocol InitialViewModelFactory {
    
}
