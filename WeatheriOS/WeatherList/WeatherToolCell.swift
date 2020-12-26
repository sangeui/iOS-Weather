//
//  WeatherToolCell.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/26.
//

import UIKit
import WeatherUIKit
import WeatherKit

class WeatherToolCell: TableViewCell {
    var viewModel: WeatherToolViewModel
    
    init(toolViewModel: WeatherToolViewModel) {
        self.viewModel = toolViewModel
        super.init(reuseIdentifier: "ToolCell")
        backgroundColor = .yellow
    }
}
