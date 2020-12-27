//
//  SearchController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/27.
//

import UIKit
import WeatherUIKit

class Weatherroller: UISearchController {
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
