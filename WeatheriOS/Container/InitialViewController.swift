//
//  InitialViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherUIKit
import WeatherKit

public class InitialViewController: ViewController {
    var fullWeatherResponder: FullWeatherResponder
    var simpleWeatherResponder: SimpleWeatherResponder
    
    init(_ fullWeatherResponder: FullWeatherResponder,
         _ simpleWeatherResponder: SimpleWeatherResponder) {
        self.fullWeatherResponder = fullWeatherResponder
        self.simpleWeatherResponder = simpleWeatherResponder
        
        super.init()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        simpleWeatherResponder.reqeustSimpleWeatherView()
    }
}

protocol InitialViewModelFactory {
    
}
