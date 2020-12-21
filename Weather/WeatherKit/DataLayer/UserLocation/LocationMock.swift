//
//  LocationMock.swift
//  WeatherKit
//
//  Created by 서상의 on 2020/12/21.
//

import Foundation

class LocationMock: LocationProtocol {
    enum MockError: Error {
        case mockError
        case indexError
    }
    private lazy var mockData: [Coordination]? = {
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let decoded: [Coordination] = try? JSONDecoder().decode([Coordination].self, from: data) else { return nil }
        return decoded
    } ()
    
    func getUserLocation(type: LocationRequestType, completion: @escaping LocationHandler) {
        switch type {
        case .once:
            guard let mock = mockData else { completion(.failure(MockError.mockError)); return }
            guard let index = randomIndex() else { completion(.failure(MockError.indexError)); return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                completion(.success(mock[index]))
            }
        case .tracking: break
        }
    }
}
private extension LocationMock {
    var resource: String { return "LocationData" }
    var ext: String { return "json" }
    var url: URL { return Bundle.main.url(forResource: resource, withExtension: ext)! }
    func randomIndex() -> Int? {
        guard let count = mockData?.count else { return nil }
        return Int.random(in: 0..<count)
    }
}
private extension Coordination {
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}
