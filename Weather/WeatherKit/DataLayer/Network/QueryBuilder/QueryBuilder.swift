//
//  QueryBuilder.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

protocol QueryBuilder: class {
    var root: String { get }
    var query: String { get set }
    func build() -> String
}
extension QueryBuilder {
    func addAmpersandIfNeeded() {
        if !query.isEmpty { query.append("&") }
        else { query.append("?") }
    }
}
enum Query {
    class OneCall: QueryBuilder {
        var root: String = "onecall"
        var query: String = ""
        
        func latitude(_ latitude: String) -> Self {
            appendParameter("lat=\(latitude)")
            return self
        }
        func longitude(_ longitude: String) -> Self {
            appendParameter("lon=\(longitude)")
            return self
        }
        
        /// Pass the forecast option, which will be excluded when you call the API later.
        /// You don't need to call this method directly, because the above layer will do it instead.
        /// - Parameter exclude: Options separated by commas, typed `String`
        /// - Returns: It will return `Self`, for chaining method call.
        func exclude(_ exclude: String) -> Self {
            appendParameter("exclude=\(exclude)")
            return self
        }
        func appid(_ appid: String) -> Self {
            appendParameter("appid=\(appid)")
            return self
        }
        func build() -> String {
            defer { query.removeAll() }
            return root+query
        }
        private func appendParameter(_ parameter: String) {
            addAmpersandIfNeeded()
            query.append(parameter)
        }
    }
}
