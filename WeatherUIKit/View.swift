//
//  View.swift
//  WeatherUIKit
//
//  Created by 서상의 on 2020/12/25.
//

import UIKit

open class View: UIView {
    public init() { super.init(frame: .zero) }
    
    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder aDecoder: NSCoder) {
      fatalError("지원하지 않음")
    }
}
