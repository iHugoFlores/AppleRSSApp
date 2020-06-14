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
        guard let url = URL(string: "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/f2/5e/7c/f25e7cd1-aac9-2f16-e835-0f4124096ffd/20CRGIM20766.rgb.jpg/200x200bb.png") else { fatalError("Endpoint URL error") }
        return URLRequest(url: url)
    }()
    
    func test_getData() {
        let expectation = XCTestExpectation(description: "Data downloaded")
        let networkHandler = NetworkEngine()
        networkHandler.getData(request: urlRequest, cacheEnabled: false) { (result) in
            switch result {
            case .success(let data): XCTAssertNotNil(data)
            case .failure(let error): XCTFail("API Call failed. \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_getData_cached() {
        let expectation = XCTestExpectation(description: "Data downloaded")
        let networkHandler = NetworkEngine()
        networkHandler.getData(request: urlRequest, cacheEnabled: true) { (result) in
            switch result {
            case .success(let data): XCTAssertNotNil(data)
            case .failure(let error): XCTFail("API Call failed. \(error)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        // Second time does not require async exection
        networkHandler.getData(request: urlRequest, cacheEnabled: true) { (result) in
            switch result {
            case .success(let data): XCTAssertNotNil(data)
            case .failure(let error): XCTFail("API Call failed. \(error)")
            }
        }
    }
}

