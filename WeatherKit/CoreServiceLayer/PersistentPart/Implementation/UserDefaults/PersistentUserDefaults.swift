//
//  PersistentUserDefaults.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

class PersistentUserDefaults: PersistentProtocol {
    
    var unitDefaults: UnitDefaults
    var placeDefaults: PlaceDefaults
    
    init(_ unitDefaults: UnitDefaults,
         _ placeDefaults: PlaceDefaults) {
        self.unitDefaults = unitDefaults
        self.placeDefaults = placeDefaults
    }
    
    func save(_ value: Persistent.Operator.Save) {
        switch value {
        case .place(let place): savePlace(place)
        case .unit(let unit): saveUnit(unit)
        }
    }
    func load(_ type: Persistent.Operator.Load) -> Any? {
        switch type {
        case .places: return placeDefaults.value
        case .unit: return unitDefaults.value
        }
    }
    func delete(_ type: Persistent.Operator.Delete) -> Success {
        switch type { case .place(let timestamp): return deletePlace(with: timestamp) }
    }
}
private extension PersistentUserDefaults {
    func savePlace(_ place: Place) {
        let timestamp = String(NSDate().timeIntervalSince1970)
        let uniquePlace = UniquePlace(place: place, timestamp: timestamp)
        let existingPlace = placeDefaults.value ?? []
        placeDefaults.value = existingPlace + [uniquePlace]
    }
    func saveUnit(_ unit: TemperatureUnit) {
        unitDefaults.value = unit
    }
    func deletePlace(with timestamp: TimeStamp) -> Success {
        guard let places = placeDefaults.value else { return false }
        let filtered = places.filter({ $0.timestamp != timestamp })
        placeDefaults.value = filtered
        return true
    }
}
