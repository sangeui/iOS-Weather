//
//  SimpleWeatherViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherUIKit
import SangeuiLayout

public class WeatherListViewController: ViewController {
    
    var tableviewHeight: NSLayoutConstraint!
    
    public override func viewDidLoad() {
        let tableview = UITableView()
        tableview.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.top.equal(to: self.view.topAnchor)
        })
        
        tableviewHeight = tableview.heightAnchor.constraint(equalToConstant: 0)
        tableviewHeight.isActive = true
        
        let toolbar = UIView()
        toolbar.backgroundColor = .yellow
        toolbar.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.bottom.equal(to: self.view.bottomAnchor)
            proxy.top.equal(to: tableview.bottomAnchor)
        })
    }
}
