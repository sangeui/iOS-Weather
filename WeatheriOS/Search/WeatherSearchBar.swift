//
//  WeatherSearchBar.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/27.
//

import WeatherUIKit

class WeatherSearchBar: SearchBar {
    init(placeHolder: String) {
        super.init()
        
        self.showsCancelButton = true
        self.placeholder = placeHolder
    }
}
