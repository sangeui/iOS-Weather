//
//  WeatherListCell.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/26.
//

import UIKit
import SangeuiLayout
import WeatherUIKit

enum ListCellType {
    case top, normal
}

class WeatherListCell: TableViewCell {
    var type: ListCellType
    var clipView: View
    override func draw(_ rect: CGRect) {
        switch type {
        case .top:
            clipView.layout(using: { proxy in
                proxy.becomeChild(of: self)
                proxy.leading.equal(to: self.layoutMarginsGuide.leadingAnchor)
                proxy.trailing.equal(to: self.layoutMarginsGuide.trailingAnchor)
                proxy.top.equal(to: self.topAnchor, offsetBy: window?.safeAreaInsets.top ?? 0)
                proxy.bottom.equal(to: self.layoutMarginsGuide.bottomAnchor)
            })
        default:
            clipView.layout(using: { proxy in
                proxy.becomeChild(of: self)
                proxy.leading.equal(to: self.layoutMarginsGuide.leadingAnchor)
                proxy.trailing.equal(to: self.layoutMarginsGuide.trailingAnchor)
                proxy.top.equal(to: self.layoutMarginsGuide.topAnchor)
                proxy.bottom.equal(to: self.layoutMarginsGuide.bottomAnchor)
            })
        }
    }
    init(type: ListCellType) {
        self.type = type
        self.clipView = View()
        super.init(reuseIdentifier: "ListCell")
        
        let hStack = UIStackView()
        hStack.distribution = .equalSpacing
        hStack.layout(using: { proxy in
            proxy.becomeChild(of: clipView)
            proxy.leading.equal(to: clipView.leadingAnchor)
            proxy.trailing.equal(to: clipView.trailingAnchor)
            proxy.top.equal(to: clipView.topAnchor)
            proxy.bottom.equal(to: clipView.bottomAnchor)
        })
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        hStack.addArrangedSubview(vStack)
        
        let sub = UILabel()
        sub.text = "중구"
        let main = UILabel()
        main.text = "나의 위치"
        let temp = UILabel()
        temp.text = "9"
        vStack.addArrangedSubview(sub)
        vStack.addArrangedSubview(main)
        hStack.addArrangedSubview(temp)
    }
}
