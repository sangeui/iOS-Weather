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
        
        self.isUserInteractionEnabled = true
        
        let hStack = UIStackView()

        hStack.distribution = .equalSpacing
        hStack.layout(using: { proxy in
            proxy.becomeChild(of: self)
            proxy.leading.equal(to: self.layoutMarginsGuide.leadingAnchor)
            proxy.trailing.equal(to: self.layoutMarginsGuide.trailingAnchor)
            proxy.bottom.equal(to: self.safeAreaLayoutGuide.bottomAnchor)
            proxy.top.equal(to: self.layoutMarginsGuide.topAnchor)
        })
        
        self.backgroundColor = .clear
        
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(with: UIImage(), at: 0, animated: true)
        segmentedControl.insertSegment(with: UIImage(), at: 1, animated: true)
        segmentedControl.setTitle("A", forSegmentAt: 0)
        segmentedControl.setTitle("B", forSegmentAt: 1)
        segmentedControl.backgroundColor = .white
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let myDivider = UILabel()
        myDivider.textColor = .lightGray
        myDivider.text = "/"
        
        myDivider.layout(using: { proxy in
            proxy.becomeChild(of: segmentedControl)
            proxy.centerX.equal(to: segmentedControl.centerXAnchor)
            proxy.centerY.equal(to: segmentedControl.centerYAnchor)
        })
        
        let magnifyingGlass = UIImage(systemName: "magnifyingglass")?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.white)
        let searchButton = UIButton()
        searchButton.setImage(magnifyingGlass, for: .normal)
        searchButton.contentMode = .scaleAspectFill
        searchButton.addTarget(nil, action: #selector(test), for: .touchUpInside)
        
        hStack.addArrangedSubview(segmentedControl)
        hStack.addArrangedSubview(searchButton)
    }
    @objc func test() { print("Touched") }
}

extension UIStackView {
    func makeBackGroundColorView(_ color: UIColor) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        backgroundView.layout(using: { proxy in
            proxy.becomeChild(of: self)
            proxy.leading.equal(to: self.leadingAnchor)
            proxy.trailing.equal(to: self.trailingAnchor)
            proxy.top.equal(to: self.topAnchor)
            proxy.bottom.equal(to: self.bottomAnchor)
        })
    }
}
