# iOS-Weather

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0" />

# WeatherKit-Persistent Part

---

![Persistent%20Part%20b08a3869ccff424d8a89d8ea74fa44fd/Weather-Persistent-Part.png](Persistent%20Part%20b08a3869ccff424d8a89d8ea74fa44fd/Weather-Persistent-Part.png)

WeatherKit의 Persistent Part 다이어그램

사용자는 다음과 같은 행동을 할 수 있다.

- 기온의 형식을 변경한다. → `Unit` 데이터
- 원하는 지역의 날씨 정보를 위해 해당 지역을 추가하거나, 나중에 삭제할 수 있다.  → `Location` 데이터

두가지 정보를 앱의 생명주기와 관련없이 유지해야 하는데, 저장될 데이터가 복잡하지 않으며 많지 않다는 것을 생각해 `UserDefaults`를 사용했다.

단, 다른 솔루션으로의 전환이 용이할 수 있도록 최소한의 장치를 두고자 `Storage` 프로토콜을 정의했다.

```swift
protocol Storage {
    func save(_ data: Storable.Save)
    func load(_ type: Storable.Load) -> Any?
    func delete(_ data: Storable.Delete) -> Bool
}
```

## Storage With UserDefaults

`Storage` 를 구현하고, 이와 별개로 각각의 정보를 저장하기 위한 두개의`UserDefaultsProtocol` 구현체를 갖도록 했다. 즉, `UnitDefaults`와 `LocationsDefaults`에 대한 의존성을 갖는다. 

```swift
class StorageUserDefaults: Storage {
    var unitDefaults: UnitDefaults
    var locationsDefaults: LocationsDefaults
    
    init(_ unitDefaults: UnitDefaults, 
             _ locationsDefaults: LocationsDefaults) {
        ...
    }
}
```

`Storage` 메소드의 파라미터를 분기하여 적절하게 처리한다.

```swift
class StorageUserDefaults: Storage {
    ...
    func save(_ data: Storable.Save) {
        switch data {
            case .unit(let unit): // Behavior to save data
            case .location(let location): // Behavior to save data
        }
    }
    func load(_ type: Storable.Load) -> Any? {
        switch type {
            case .unit: // Behavior for getting data
            case .locations: // Behavior for getting data
        }
    }
    func delete(_ data: Storable.Delete) -> Bool {
        switch data {
            case .location(let timestamp): // Behavior to delete data
        }
    }
}
```

## UserDefaultsProtocol

`StorageUserDefaults`가 데이터를 다루기 위해 사용하는 `UnitDefaults`와 `LocationsDefaults`는 모두 `UserDefaultsProtocol`을 따른다.

목적이 있다기 보다는 단순히 클래스의 코드를 간결하게 하고자 별도로 정의해 따르도록 했다. 

```swift
protocol UserDefaultsProtocol {
    var key: Key { get set }
    var defaults: UserDefaults { get set }
    
    func getDataFromDefaults(with key: Key) -> Data?
    func getValueFromData<T: Decodable>(_ data: Data) -> T?
}
extension UserDefaultsProtocol {
    var encoder: PropertyListEncoder { return PropertyListEncoder() }
    var decoder: PropertyListDecoder { return PropertyListDecoder() }
}
extension UserDefaultsProtocol {
    // `defaults`에 `key`를 이용해 접근하여 `Data`를 반환한다.
    func getDataFromDefaults(with key: Key) -> Data? {
        return defaults.value(forKey: key.rawValue) as? Data
    }
    // `decoder`를 이용해 파라미터로 전달 받은 `data`를 제네릭 타입으로 decode, 반환한다.
    func getValueFromData<T: Decodable>(_ data: Data) -> T? {
        return try? decoder.decode(T.self, from: data)
    } 
}
```

### UnitDefaults & LocationsDefaults

`UserDefaultsProtocol`을 구현한 타입이다. 원래 Property Wrapper를 사용하려고 했는데, 테스트가 어려워 (경험 부족 탓일 것이다) 비슷하게 다시 구현해서 사용했다. 

- UnitDefaults 또는 LocationsDefaults를 테스트할 때, 외부에서 `defaults`를 주입하기가 어려웠다.

```swift
struct UnitDefaults: UserDefaultsProtocol {
    var key: Key
    var defaults: UserDefaults

    var value: TemperatureUnit? {
        get {
            guard let data = defaults.string(forKey: key.rawValue) else {
                return nil
            }
            return TemperatureUnit(rawValue: data)
        }
        set {
            guard let value = newValue else { return }
            defaults.setValue(value, forKey: key.rawValue)
        }
    }
}

struct LocationsDefaults: UserDefaultsBase {
    var key: Key
    var defaults: UserDefaults
    
    var value: UserSavedLocations? {
        get {
            guard let data = getDataFromDefaults(with: key) else { return nil }
            guard let value: UserSavedLocations = getValueFromData(data) else { return nil }
            return value
        }
        set {
            guard let data = try? encoder.encode(newValue) else { return }
            defaults.setValue(data, forKey: key.rawValue)
        }
    }
}
```
