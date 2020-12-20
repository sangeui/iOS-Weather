//
//  WeatherUserDefaults.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/16.
//

import Foundation

typealias UserSavedLocations = [String: Location]
typealias UserSavedLocation = (timestamp: String, location: Location)

class StorageUserDefaults: Storage {
    
    var unitDefaults: UnitDefaults
    var locationsDefaults: LocationsDefaults
    
    init(_ unitDefaults: UnitDefaults,
         _ locationsDefaults: LocationsDefaults) {
        self.unitDefaults = unitDefaults
        self.locationsDefaults = locationsDefaults
    }
    
    func save(_ data: Storable.Save) {
        switch data {
        case .unit(let unit): unitDefaults.value = unit
        case .location(let location):
            let timestamp = String(NSDate().timeIntervalSince1970)
            let identifableLocation = IdentifiableLocation(location: location, timestamp: timestamp)
            var existingLocations = locationsDefaults.value ?? []
            existingLocations.append(identifableLocation)
            locationsDefaults.value = existingLocations
        }
    }
    func load(_ type: Storable.Load) -> Any? {
        switch type {
        case .unit: return unitDefaults.value
        case .locations: return locationsDefaults.value
        }
    }
    func delete(_ data: Storable.Delete) -> Bool {
        switch data {
        case .location(let identifier):
            if let locations = locationsDefaults.value {
                let filtered = locations.filter { $0.timestamp != identifier }
                locationsDefaults.value = filtered
                return true
            }
        }
        return false
    }
}

struct Key: RawRepresentable {
    let rawValue: String
}
extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) { rawValue = stringLiteral }
}
extension Key {
    static let temperatureUnit: Key = "temperatureUnit"
    static let locations: Key = "locations"
}
