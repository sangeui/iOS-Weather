//
//  TableViewCell.swift
//  WeatherUIKit
//
//  Created by 서상의 on 2020/12/26.
//

import UIKit

open class TableViewCell: UITableViewCell {
    public init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder: NSCoder) {
        fatalError("지원하지 않음")
    }
}
