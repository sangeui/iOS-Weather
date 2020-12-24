//
//  PageViewController.swift
//  WeatherUIKit
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit

open class PageViewController: UIPageViewController {
    public init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder: NSCoder) {
        fatalError("지원하지 않음")
    }
}
