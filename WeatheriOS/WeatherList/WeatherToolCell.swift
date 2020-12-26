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
    
    private let searchButton = UIButton()
    private let hStack = UIStackView()
    
    init(toolViewModel: WeatherToolViewModel) {
        self.viewModel = toolViewModel
        super.init(reuseIdentifier: "ToolCell")
        
        hStack.distribution = .equalSpacing
        hStack.alignment = .top
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
        segmentedControl.setTitle("°C", forSegmentAt: 0)
        segmentedControl.setTitle("°F", forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
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
        searchButton.setImage(magnifyingGlass, for: .normal)
        searchButton.contentMode = .scaleAspectFill
        searchButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        
        view.layout(using: { proxy in
            proxy.becomeChild(of: hStack)
            proxy.width.equal(toConstant: self.frame.height * 0.8)
            proxy.height.equal(toConstant: self.frame.height * 0.8)
            proxy.centerX.equal(to: hStack.centerXAnchor)
            proxy.top.equal(to: hStack.topAnchor)
        })
        
        hStack.addArrangedSubview(segmentedControl)
        hStack.addArrangedSubview(searchButton)
    }
    @objc func test() {
        viewModel.search()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view: UIView?
        hStack.arrangedSubviews.forEach {
            if let button = $0 as? UIButton,
               $0.frame.insetBy(dx: -20, dy: -20).contains(point) {
                view = button
            } else if let control = $0 as? UISegmentedControl,
                      $0.frame.contains(point) {
                view = control
            }
        }
        return view
    }
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
