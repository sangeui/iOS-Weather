//
//  String+IsNumber.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/29.
//

import Foundation

extension String {
    var isInteger: Bool { return Int(self) != nil }
    func isSeparated(by string: String) -> Bool {
        return self.components(separatedBy: string).count > 1
    }
}
