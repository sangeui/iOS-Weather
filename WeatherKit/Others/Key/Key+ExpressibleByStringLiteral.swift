//
//  Key+ExpressibleByStringLiteral.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

extension Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) { rawValue = value }
}
