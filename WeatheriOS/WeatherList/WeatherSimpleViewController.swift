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
    
    var viewModel: WeatherSimpleViewModel
    var listViewModel: WeatherListViewModel
    var toolViewModel: WeatherToolViewModel
    
    public init(simpleViewModel: WeatherSimpleViewModel,
                listViewModel: WeatherListViewModel,
                toolsViewModel: WeatherToolViewModel) {
        self.viewModel = simpleViewModel
        self.listViewModel = listViewModel
        self.toolViewModel = toolsViewModel
        super.init()
        
        let searchController = WeatherSearchController(searchResponder: self.viewModel)
        
        viewModel.search.bind { isSearchRequested in
            if isSearchRequested { self.present(searchController, animated: true, completion: nil) }
            else {
                if let presentedController = self.presentedViewController as? WeatherSearchController {
                    presentedController.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let tableview = WeatherListView(listViewModel: listViewModel, toolViewModel: toolViewModel)
        tableview.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.top.equal(to: self.view.topAnchor)
            proxy.bottom.equal(to: self.view.bottomAnchor)
        })
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
