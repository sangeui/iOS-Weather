//
//  WeatherSearchResultCell.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/29.
//

import WeatherUIKit

class WeatherSearchResultCell: TableViewCell {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.textLabel?.textColor = .gray
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    func setText(_ text: String) {
        self.textLabel?.text = text
    }
    func setAttributedText(_ text: NSMutableAttributedString) {
        self.textLabel?.attributedText = text
    }
}
