//
//  Weathers.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/24.
//

import Foundation

public protocol WeatherProvider {
    
    var weathers: Box<[WeatherInformation]> { get set }
}

public class Weathers: WeatherProvider {

    public var weathers: Box<[WeatherInformation]> = Box([])
    
    private let network: NetworkManager
    private let persistent: PersistentProtocol
    private let location: LocationManager
    
    public init(_ network: NetworkManager,
         _ persistent: PersistentProtocol,
         _ location: LocationManager) {
        self.network = network
        self.persistent = persistent
        self.location = location
    }
    
    public func getUserWeather() {
        userLocation()
    }
    
    private func populateUserWeather() {}
    private func populatePlaceWeather() {}
    private func userLocation() {
        location.getLocation { result in
            switch result {
            case .success(let coordinate):
                let place = Place(coordination: coordinate, name: "나의 위치")
                let unique = UniquePlace(place: place, timestamp: "0")
                let placeinfo = PlaceInformation(uniquePlace: unique, metadata: .user)
                let weatherInfo = WeatherInformation(weather: nil, place: placeinfo)
                self.weathers.value.insert(weatherInfo, at: 0)
                self.makeUserWeather(coordinate)
            case .failure(let error): print(error)
            }
        }
    }
    private func makeUserWeather(_ coordinate: Coordinate) {
        network.weather(coordination: coordinate, options: [.current, .minutely, .hourly, .daily]) { result in
            switch result {
            case .success(let information):
                guard var userWeather = self.weathers.value.first,
                      userWeather.place.metadata == .user else { return }
                userWeather.weather = information
                self.weathers.value[0] = userWeather
                
            case .failure(let error): print(error)
            }
        }
    }
    private func weather(_ coordinate: Coordinate) {
        network.weather(coordination: coordinate, options: [.current, .minutely, .hourly, .daily]) { result in
            switch result {
            case .success(let information): break
            case .failure(let error): break
            }
        }
    }
}
