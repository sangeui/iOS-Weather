//
//  WeatherKitTests.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/21.
//

import XCTest
@testable import WeatherKit

class WeatherKitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let exp = expectation(description: "Network")
        let provider = OpenWeatherMapOneCall()
        let manager = NetworkManager(network: URLSession.shared, weather: provider)
        let coordination = Coordination(latitude: 35.56328946686666, longitude: 129.33301672116067)

        manager.weather(coordination: coordination, options: [.current]) { result in
            switch result {
            case .success(let information): print("RESULT", information)
            case .failure(let error): print(error)
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
