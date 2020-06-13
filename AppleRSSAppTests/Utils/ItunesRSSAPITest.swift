//
//  ItunesRSSAPITest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/13/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class ItunesRSSAPITest: XCTestCase {
    func test_getFeed_jsonParseError() {
        let networkHandler = MockNetwork()
        networkHandler.data = "Test".data(using: .utf8)
        ItunesRSSAPI.getFeed(interface: networkHandler) { (result) in
            switch result {
            case .success: XCTFail("The test should have failed")
            case .failure(let error):
                switch error {
                case .jsonParsingError: XCTAssertTrue(true)
                default: XCTFail("Error should have been jsonParsingError")
                }
            }
        }
    }
}
