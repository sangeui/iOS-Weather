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
            var existingLocations = locationsDefaults.value ?? [:]
            existingLocations.updateValue(location.location, forKey: location.timestamp)
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
            if var locations = locationsDefaults.value {
                locations.removeValue(forKey: identifier)
                locationsDefaults.value = locations
                return true
            }
        }
        return false
    }
}


extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "Weather")
        return combined
    }
}
protocol UserDefaultsBase {}
extension UserDefaultsBase {
    var encoder: PropertyListEncoder { return PropertyListEncoder() }
    var decoder: PropertyListDecoder { return PropertyListDecoder() }
    var standard: UserDefaults { return UserDefaults.standard }
}

@propertyWrapper
struct WeatherTempUnitUserDefaults<T: PropertyListValue>: UserDefaultsBase {
    let key: Key
    let defaults: UserDefaults
    var wrappedValue: T? {
        get {
            let value = defaults.value(forKey: key.rawValue) as! String
            return TemperatureUnit(rawValue: value) as? T
        }
        set {
            if let value = newValue as? TemperatureUnit {
                defaults.setValue(value.rawValue, forKey: key.rawValue)
            }
            
        }
    }
}
@propertyWrapper
struct WeatherLocationsUserDefaults<T: PropertyListValue & Codable>: UserDefaultsBase {
    let key: Key
    let defaults: UserDefaults
    var wrappedValue: T? {
        get {
            guard let data = defaults.value(forKey: key.rawValue) as? Data else { return nil }
            guard let locations = try? decoder.decode([[String:Location]].self, from: data) else { return nil }
            return locations as? T
        }
        set {
            
            if let data = try? encoder.encode(newValue) {
                defaults.setValue(data, forKey: key.rawValue)
            }
        }
    }
}
protocol PropertyListValue {}
extension Data: PropertyListValue {}
extension String: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}
extension Location: PropertyListValue {}

// Every element must be a property-list type
extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}
struct Key: RawRepresentable {
    let rawValue: String
}
extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) { rawValue = stringLiteral }
}
extension Key {
    static let unitOfTemperature: Key = "unitOfTemperature"
    static let locations: Key = "locations"
}
