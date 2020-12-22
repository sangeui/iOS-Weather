//
//  TestsUserDefaultProtocol.swift
//  WeatherKitTests
//
//  Created by 서상의 on 2020/12/22.
//

import XCTest
@testable import WeatherKit

class TestsUserDefaultProtocol: XCTestCase {
    var key: Key!
    var defaults: UserDefaults!
    let suiteName = "Test"
    var mock: UserDefaultsProtocol!
    
    func givenSavedAny(_ value: Any?) {
        mock.saveValue(value, with: key)
    }
    func loadSavedAnyAsData() -> Data? {
        return mock.loadData(with: key)
    }
    func makeStringData(_ string: String, using: String.Encoding) -> Data? {
        return string.data(using: using)
    }
    override func setUp() {
        key = Key.test
        defaults = UserDefaults(suiteName: suiteName)
        mock = UserDefaultsProtocolMock(key: key, defaults: defaults)
    }
    override func tearDown() {
        mock = nil
        defaults = nil
        key = nil
        
        UserDefaults.standard.removeSuite(named: suiteName)
    }
    
    func testWhenLoadValueGivenSavedValue() {
        let givenValue = "A"
        givenSavedAny(givenValue)
        
        let loaded = mock.loadValue(with: key) as? String
        
        XCTAssertNotNil(loaded)
        XCTAssertEqual(loaded!, "A")
    }
    // 이미 저장된 Data 형태의 값이 존재할 때,
    // 주어진 키와 관련된 데이터를 불러오는 테스트
    func testLoadDataWithKeyWhenGivenStoredData() {
        let text = "It's not my fault."
        let data = makeStringData(text, using: .utf8)
        givenSavedAny(data)
        
        // When
        let loaded = mock.loadData(with: key)
        
        XCTAssertNotNil(loaded)
        XCTAssertEqual(loaded, data)
    }
    // 저장된 Data 형태의 값을 불러오고
    // 이를 적당한 형태로 디코딩하는 테스트
    func testLoadValueFromDataWhenGivenStoredData() {
        let text = "Oh god..."
        let data = makeStringData(text, using: .utf8)
        givenSavedAny(data)
        
        let loadedData = loadSavedAnyAsData()
        XCTAssertNotNil(loadedData)
        
        let loadedString = mock.loadString(from: loadedData!, using: .utf8)
        XCTAssertNotNil(loadedString)
        
        XCTAssertEqual(loadedString, text)
    }
}
extension Key {
    static let test: Key = "test"
}
