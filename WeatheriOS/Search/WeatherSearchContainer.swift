//
//  WeatherSearchContainer.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/27.
//

import UIKit
import WeatherUIKit

class WeatherSearchContainer: ViewController {
    var searchController: UISearchController
    init(_ searchController: UISearchController) {
        self.searchController = searchController
        super.init()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.present(searchController, animated: true, completion: nil)
    }
}
