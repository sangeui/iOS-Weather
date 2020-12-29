//
//  WeatherSearchBar.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/27.
//

import WeatherUIKit
import UIKit

class WeatherSearchBar: SearchBar {
    init(delegate: UISearchBarDelegate, placeHolder: String) {
        super.init()
        
        self.showsCancelButton = true
        self.placeholder = placeHolder
    }
}
