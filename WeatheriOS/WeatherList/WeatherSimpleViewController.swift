//
//  SimpleWeatherViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherUIKit
import WeatherKit
import SangeuiLayout

public class WeatherSimpleViewController: ViewController {
    
    var listViewModel: WeatherListViewModel
    var toolViewModel: WeatherToolViewModel
    
    public init(simpleViewModel: WeatherSimpleViewModel,
                listViewModel: WeatherListViewModel,
                toolsViewModel: WeatherToolViewModel) {
        self.listViewModel = listViewModel
        self.toolViewModel = toolsViewModel
        super.init()
    }
    
    public override func viewDidLoad() {
        self.view.layer.cornerRadius = 50
        self.view.clipsToBounds = true
        let tableview = WeatherListView(listViewModel: listViewModel, toolViewModel: toolViewModel)
        tableview.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.top.equal(to: self.view.topAnchor)
            proxy.bottom.equal(to: self.view.bottomAnchor)
        })
    }
}
