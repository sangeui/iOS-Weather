# iOS-Weather

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0" />

---

# Objectives
- WeatheriOS
- WeatherKit
    - UserInterface Layer · ViewModel Part
    - Network Part
        - [X] 구현
        - [ ] 테스트
    - Persistent Part
        - [X] 구현
        - [ ] 테스트
    - Location Part
        - [ ] 구현
        - [ ] 테스트

---
# Table of Contents
1. [WeatheriOS](#)
2. [WeatherKit](#WeatherKit)
    1. [WeatherKit Persistent Part](#WeatherKit-Persistent-Part)
    2. [WeatherKit Network Part](#WeatherKit-Network-Part)
    3. [WeatherKit Model Part](#WeatherKit-Model-Set)
---
# WeatherKit
---
# WeatherKit-Persistent-Part

---

![Weather-Persistent-Part](https://user-images.githubusercontent.com/34618339/102711565-0486c680-42fe-11eb-881d-e029e0d5741d.png)


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
# WeatherKit-Network-Part

![WeatherKit-Network-Part](https://user-images.githubusercontent.com/34618339/102688896-63383b80-423d-11eb-9e99-3f9f42514ad8.png)

WeatherKit-Network-Part Diagram

## Network Manager

그림에서 알 수 있듯이, 상위 레이어 (UI Layer, 화면에 보여지는 유저 인터페이스 레이어가 아님)와 메시지를 주고 받는, API를 호출하는 진입점 역할을 한다. 

사용할 날씨 정보 제공자를 결정하는 `WeatherProvider`와 실제로 네트워크 통신이 이루어지는 `NetworkSession`의 의존성을 가진다.

```swift
class NetworkManager {
    private let provider: WeatherProvider
    private let session: NetworkSession

    init(provider: WeatherProvider, session: NetworkSession = URLSession.shared) {
        self.provider = provider
        self.session = session
    }
    ...
}
```

- **WeatherProvider**

    날씨 정보 제공자가 바뀌어도 영향이 없도록 프로토콜로 정의했다. 다만 제공자에 따라 하나 혹은 두개 이상의 API 호출이 이루어질 수 있을 것인데, 이것은 고려하지 않았다. 즉, API 호출 하나로 날씨 정보를 가져온다고 가정하고 정의했다. `문제가 될 수 있을 것 같다.`

- **NetworkSession**

    기존에는 URLSession.shared 를 직접 할당했다. 테스트에 문제가 있어 프로토콜을 별도로 정의하고 초기화 단계에서 주입받도록 했다. 
    기본 값으로 `URLSession.shared` 를 할당할 수 있는 것은 `NetworkSession` 을 따르기 때문이다.

---

```swift
class NetworkManager {
    ...
    func weather(location: Location,
                                options: [ForecastOption],
                                completion: @escaping (Result<WeatherModel.Data, Error>) -> Void)
    ...
    let url = ... // Make URL whatever way you want.
    session.execute(url, completion)
}
```

- **func weather(location:options:completion:)**

    유일하게 갖는 인터페이스 메소드이다. 파라미터의 이름은 직관적이므로 그 의미를 알기 쉽게 했다. 

    - location: `Location` 타입으로, 좌표 값을 가진다.
    - options: `ForecastOption` 은 받고자 하는 날씨 예보 `Enum` 타입이다. OpenWeatherMap의 쿼리 파라미터를 기준으로 작성했다. `current` · `minutely` · `hourly` · `daily`, 총 네 종류의 케이스를 가진다.
    - completion: `Result`를 인자로 받는 클로져이다.

    메소드의 바디에서는 `URL`을 만들고 이를 전달 받은 `completion`과 함께 `session`으로 전달한다. 

## Network Session

언급했던 처럼, `NetworkManager`에서 `URLSession`을 직접 사용하다보니 테스트가 어려웠다. `NetworkSession` 프로토콜을 정의하고 `URLSession`에서 이를 따르도록 확장했다. `NetworkSessionMock`을 만들어 테스트도 가능하다. 

```swift
protocol NetworkSession {
    func execute<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}
```

- **func execute<T: Decodable>(url:completion:)**
    - url: 기존에는 `String`으로 설정했으나, 검증이 끝난 `URL`을 받아오는 것으로 했다.
    - completion: `Result`를 인자로 받는 클로져이다.

마지막으로 `URLSession`이 위 프로토콜을 따르도록 확장했다.

```swift
extension URLSession: NetworkSession {
    func execute<T>(url: URL, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        let task = dataTask(with: url, completionHandler: {
            ...
        }
        task.resume()
    }
}
```

## Weather Provider

특정 날씨 정보 제공자에게 종속되지 않도록 하기 위한 최소한의 장치로써 해당 프로토콜을 정의했다.

```swift
protocol WeatherProvider {
    var apiKey: String? { get }
    var endPoint: String { get }

    func makeURL(with location: Location, options: [ForecastOption]) -> URL?
}
```

위에서 언급한 바와 같이 어떤 하나의 API 호출을 가정하고 OpenWeatherMap을 기준으로 makeURL 메소드를 정의했는데, 위험한 생각이지 않을까 한다. 하지만 불필요하게 (API를 변경할 일이 없으므로) 더 복잡한 구조를 만들고 싶지 않아 위와 같이 두었다. 

```swift
struct OpenWeatherMapOneCall: WeatherProvider {
    var apiKey: String? = "..."
    var endPoint: String = "..."

    func makeURL(with location: Location, options: [ForecastOption]) -> URL? {
        return URL(string: endPoint + makeQuery(...))
    }
    ...
}
```
# WeatherKit-Model-Set

WeatherKit은 `UserLocation`, `Network`, `Persistent`의 총 세가지 파트로 나누어진다. ViewModel 레이어에서는 이 각각의 파트들에게 (필요시 인자와 함께) 요청을 하고, 데이터를 돌려 받는다. 

UserLocation은 사용자 위치를, Persistent에서는—몇가지 책임이 있지만 여기에서는 사용자 지정 위치를 저장하고 불러오는 것으로 특정한다—사용자 지정 위치를 다루며 Network에서는 이들 위치들을 이용해 날씨 정보를 가져오는 책임을 담당한다.

가져오는 데이터의 종류가 제각기이기 때문에, 어떻게 필요한 모델을 정리할 수 있을지 고민하다가 우선 아래 다이어그램을 만들었다.

---

![Model Sets](https://user-images.githubusercontent.com/34618339/102711537-c2f61b80-42fd-11eb-8807-0951906f4a53.png)

WeatherKit Model Sets Diagram

~~‼️ User Location Model Set 에서 불필요한 하위 모델을 제거했는데, Custom Location Model Set과 타입이 달라져 한 배열에 속할 수 없다. WeatheriOS 모듈에서 이를 어떻게 처리할지 강제해야 한다.~~ 

- ~~한 배열에 두 세트를 모두 넣고, 유저 인터페이스 구성시 이를 다르게 처리~~
- ~~별개의 데이터 세트 그대로 두고 처리~~

편의상 각각의 모델 세트로 나눈 것이며, 이들은 동일한 구조를 가진다.

- **Coordination**

    가장 저수준의 모델에는 `Coordination`이 있다. `Name`은 단순 문자열이므로 논외로 한다. 

    ```swift
    struct Coordination {
        var latitude: String
        var longitude: String
    }
    ```

- **Location**

    `Coordination`과 `Name`을 갖는 모델이다. 

    ```swift
    struct Location {
        var name: String
        var coordination: Coordination
    }
    ```

- **Identifiable Location**

    `Location` 모델에 Time Stamp를 더한 모델이다. 여기서 Time Stamp는 사용자가 해당 위치를 저장하는 동작을 했을 때 만들어진다. Time Stamp는 각각의 사용자 지정 위치에 대한 식별자로써도 활용된다.

    ```swift
    struct IdentifiableLocation {
        var timestamp: String // Also it can be used as an identifier
        var location: Location
    }
    ```

- **Location Information**

    `IdentifiableLocation`과 메타데이터를 추가한 것이다. 

    ```swift
    struct LocationInformation {
        var metadata: Metadata // has `type` of enum, which is either `user` or `custom`
        var location: IdentifiableLocation
    }
    ```

- **Weather Information**

    `LocationInformation`과 `Weather`를 갖는 모델

    ```swift
    struct WeatherInformation {
        var weather: Weather
        var location: LocationInformation
    }
    ```

---

![WeatherKit-Data-Flow](https://user-images.githubusercontent.com/34618339/102711540-c7bacf80-42fd-11eb-923d-416a8074fee6.png)

WeatherKit Data Flow Diagram

위 다이어그램은 `WeatherKit`에서의 데이터 흐름을 보여준다.

- **UserLocation 파트의 데이터 흐름**
    - 입력: 특정 ViewModel에서 사용자 위치 요청이 들어온다.
    - 출력: `Coordination` 타입의 결과를 돌려준다.
    - 기타(출력 이후)
        1. 사용자 위치를 의미하는 이름을 지정해 `Location`을 만든다.
        2. 임의로 `timestamp`를 지정해 `IdentifiableLocation`을 만든다.
        3. 적절히 Metadata를 만들어 `LocationInformation`을 만든다.
- **Persistent 파트의 데이터 흐름**
    - 입력: 특정 ViewModel에서 Load 요청이 들어온다.
    - 출력: `IdentifiableLocation` 타입의 결과를 돌려준다.
    - 기타(출력 이후)
        1. 적절히 Metadata를 만들어 `LocationInformation`을 만든다. 
- **Network 파트의 데이터 흐름**
    - 입력: 특정 ViewModel에서 좌표 값과 함께 요청이 들어온다.
    - 출력: `Weather` 타입의 결과를 돌려준다.
    - 기타(출력 이후)
        1. 가지고 있는 `LocationInformation`에 `Weather`를 추가해 `WeatherInformation`을 완성한다.

❌ **모델을 초기에 신중하고 완전하게 정의해야 추후 불필요한 변경이 생기지 않는다.**
