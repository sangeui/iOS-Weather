//
//  PersistentProtocol.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

public typealias Success = Bool

public protocol PersistentProtocol {
    func save(_ value: Persistent.Operator.Save)
    func load(_ type: Persistent.Operator.Load) -> Any?
    func delete(_ type: Persistent.Operator.Delete) -> Success
}
