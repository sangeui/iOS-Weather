//
//  WeatherListCell.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/26.
//

import UIKit
import SangeuiLayout
import WeatherUIKit

enum ListCellType: Equatable {
    case top(CGFloat), normal
}

class WeatherListCell: TableViewCell {
    private var type: ListCellType
    private var clipView: View
    var clipViewHeightConstraint: NSLayoutConstraint!
    var clipViewHeight: CGFloat!
    
    var isListTopRow: Bool {
        if case ListCellType.top(_) = type { return true }
        else { return false }
    }
    
    init(type: ListCellType) {
        self.type = type
        self.clipView = View()
        super.init(reuseIdentifier: "ListCell")
        self.selectionStyle = .none
        switch type {
        case .top(let safeAreaTop):
            clipView.layout(using: { proxy in
                proxy.becomeChild(of: self)
                proxy.leading.equal(to: self.layoutMarginsGuide.leadingAnchor)
                proxy.trailing.equal(to: self.layoutMarginsGuide.trailingAnchor)
                proxy.bottom.equal(to: self.bottomAnchor)
            })
            clipViewHeightConstraint = clipView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -safeAreaTop)
        case .normal:
            clipView.layout(using: { proxy in
                proxy.becomeChild(of: self)
                proxy.leading.equal(to: self.layoutMarginsGuide.leadingAnchor)
                proxy.trailing.equal(to: self.layoutMarginsGuide.trailingAnchor)
                proxy.bottom.equal(to: self.bottomAnchor)
            })
            clipViewHeightConstraint = clipView.heightAnchor.constraint(equalTo: self.heightAnchor)
        }
        clipViewHeightConstraint.isActive = true
        clipViewHeightConstraint.priority = .defaultHigh
        clipViewHeight = clipViewHeightConstraint.constant
        
        self.clipView.clipsToBounds = true
        
        let sub = UILabel()
        sub.text = "중구"
        sub.font = UIFont.preferredFont(forTextStyle: .caption1)
        let main = UILabel()
        main.text = "나의 위치"
        main.font = UIFont.preferredFont(forTextStyle: .title1)
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 50, weight: .light)
        temp.adjustsFontForContentSizeCategory = true
        temp.text = "9°"
        
        let hStack = UIStackView()
        
        hStack.layout(using: { proxy in
            proxy.becomeChild(of: clipView)
            proxy.leading.equal(to: clipView.leadingAnchor)
            proxy.trailing.equal(to: clipView.trailingAnchor)
            proxy.bottom.equal(to: clipView.bottomAnchor)
            
            switch type {
            case .top(let safeAreaTop):
                proxy.height.equal(to: self.heightAnchor, offsetBy: -safeAreaTop)
            case .normal:
                proxy.height.equal(to: self.heightAnchor)
            }
        })
        
        hStack.distribution = .equalCentering
        hStack.alignment = .center
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        
        hStack.addArrangedSubview(vStack)
        hStack.addArrangedSubview(temp)
        vStack.addArrangedSubview(sub)
        vStack.addArrangedSubview(main)
    }
}
