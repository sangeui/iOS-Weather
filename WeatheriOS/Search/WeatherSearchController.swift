//
//  SearchController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/27.
//

import UIKit
import WeatherUIKit

class WeatherSearchBar: UISearchBar {
}

class WeatherSearchController: ViewController {
    private let searchBar = WeatherSearchBar()
    private var navigationBar: UINavigationBar!
    override init() {
        
        super.init()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search"
        
        navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem()
        navigationItem.prompt = "Enter city, postcode or airport location"
        navigationItem.titleView = searchBar
        navigationBar.setItems([navigationItem], animated: true)
        navigationBar.tintColor = .white
        navigationBar.barStyle = .black
        
        navigationBar.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.top.equal(to: self.view.topAnchor)
            proxy.height.equal(toConstant: 44)
        })
        
        let blurEffect = UIBlurEffect(style: .systemThickMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.bottom.equal(to: self.view.bottomAnchor)
            proxy.top.equal(to: navigationBar.bottomAnchor)
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc func willEnterForeground() {
        self.searchBar.becomeFirstResponder()
    }
    @objc func didEnterBackground() {
        self.searchBar.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { self.searchBar.becomeFirstResponder() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.searchBar.resignFirstResponder()
    }
}
