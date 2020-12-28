//
//  SearchController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/27.
//

import UIKit
import WeatherUIKit
import WeatherKit

class WeatherSearchController: ViewController {
    private let searchBar = WeatherSearchBar(placeHolder: "Search")
    private let containerBar = UINavigationBar()
    private let containerItem = UINavigationItem()
    
    private let searchResponder: SearchResponder
    
    init(searchResponder: SearchResponder) {
        self.searchResponder = searchResponder
        super.init()
        
        searchBar.delegate = self
        containerItem.prompt = "Enter city, postcode or airport location"
        containerItem.titleView = searchBar
        containerBar.setItems([containerItem], animated: true)
        containerBar.tintColor = .white
        containerBar.barStyle = .black
        
        containerBar.layout(using: { proxy in
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
            proxy.top.equal(to: containerBar.bottomAnchor)
        })
    }
    
    @objc func willEnterForeground() {
        self.searchBar.becomeFirstResponder()
    }
    @objc func didEnterBackground() {
        self.searchBar.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async { self.searchBar.becomeFirstResponder() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.searchBar.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
}
extension WeatherSearchController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResponder.closeSearchView()
    }
}
