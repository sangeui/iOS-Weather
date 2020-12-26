//
//  WeatherToolView.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/25.
//

import UIKit
import WeatherUIKit
import WeatherKit

class WeatherToolView: View {
    var viewModel: WeatherToolViewModel
    
    init(viewModel: WeatherToolViewModel) {
        self.viewModel = viewModel
        super.init()
        
        self.backgroundColor = .black
        
        // MARK: - Make Stack
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        
        stack.layout(using: { proxy in
            proxy.becomeChild(of: self)
            proxy.leading.equal(to: self.leadingAnchor)
            proxy.trailing.equal(to: self.trailingAnchor)
            proxy.top.equal(to: self.topAnchor)
            proxy.bottom.equal(to: self.safeAreaLayoutGuide.bottomAnchor)
        })
        // MARK: - Make Segmented Control
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(with: UIImage(), at: 0, animated: true)
        segmentedControl.insertSegment(with: UIImage(), at: 1, animated: true)
        segmentedControl.setTitle("First", forSegmentAt: 0)
        segmentedControl.setTitle("Second", forSegmentAt: 1)
        
        stack.addArrangedSubview(segmentedControl)
    }
}
