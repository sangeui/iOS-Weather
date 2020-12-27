//
//  SearchBar.swift
//  WeatherUIKit
//
//  Created by 서상의 on 2020/12/27.
//

import UIKit

open class SearchBar: UISearchBar {
    public init() {
        super.init(frame: .zero)
    }
    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder: NSCoder) {
        fatalError("지원하지 않음")
    }
}
