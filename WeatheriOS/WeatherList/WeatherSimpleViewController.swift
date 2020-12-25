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
    var toolsViewModel: WeatherToolsViewModel
    
    public init(simpleViewModel: WeatherSimpleViewModel,
                listViewModel: WeatherListViewModel,
                toolsViewModel: WeatherToolsViewModel) {
        self.listViewModel = listViewModel
        self.toolsViewModel = toolsViewModel
        super.init()
    }
    
    public override func viewDidLoad() {
        let tableview = WeatherListView(viewModel: listViewModel)
        tableview.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.top.equal(to: self.view.topAnchor)
        })
        
        let toolbar = WeatherToolView(viewModel: toolsViewModel)
        toolbar.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.bottom.equal(to: self.view.bottomAnchor)
            proxy.top.equal(to: tableview.bottomAnchor)
        })
    }
}
