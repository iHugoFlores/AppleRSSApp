//
//  NetworkEngineTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/14/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class NetworkEngineTest: XCTestCase {
    let urlRequest: URLRequest = {
        guard let url = URL(string: "https://www.google.com/") else { fatalError("Endpoint URL error") }
        return URLRequest(url: url)
    }()

    func test_cache() {
        let networkHandler = NetworkEngine(urlSession: URLSession.shared)
        guard let testData = "Test".data(using: .utf8) else { fatalError() }
        networkHandler.setCachedData(key: "https://www.google.com/", data: testData)
        guard let stored = networkHandler.getCachedData(key: "https://www.google.com/") else { fatalError() }
        XCTAssertEqual(stored, testData)
        networkHandler.getData(request: urlRequest, cacheEnabled: true) { (result) in
            switch result {
            case .success(let data): XCTAssertNotNil(data)
            case .failure(let error): XCTFail("API Call failed. \(error)")
            }
        }
    }
}

