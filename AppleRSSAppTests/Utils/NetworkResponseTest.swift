//
//  NetworkResponseTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/13/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class NetworkResponseTest: XCTestCase {
    func test_fail_requestError() {
        let error: NetworkError = .unexpected
        let request = NetworkResponse(data: nil, response: nil, error: error)
        switch request {
        case .failure(let error):
            switch error {
            case .requestError: XCTAssertTrue(true)
            default: XCTFail("Wrong error type")
            }
        default: XCTFail("Should have failed")
        }
    }
    
    func test_fail_noResponse() {
        let request = NetworkResponse(data: nil, response: nil, error: nil)
        switch request {
        case .failure(let error):
            switch error {
            case .noResponseError: XCTAssertTrue(true)
            default: XCTFail("Wrong error type")
            }
        default: XCTFail("Should have failed")
        }
    }
    
    func test_fail_serverError() {
        guard let url = URL(string: "www.google.com") else { fatalError("Endpoint URL error") }
        let response = HTTPURLResponse(url: url, statusCode: 100, httpVersion: nil, headerFields: nil)
        let request = NetworkResponse(data: nil, response: response, error: nil)
        switch request {
        case .failure(let error):
            switch error {
            case .serverError: XCTAssertTrue(true)
            default: XCTFail("Wrong error type")
            }
        default: XCTFail("Should have failed")
        }
    }
    
    func test_success() {
        guard let url = URL(string: "www.google.com") else { fatalError("Endpoint URL error") }
        let response = HTTPURLResponse(url: url, statusCode: 201, httpVersion: nil, headerFields: nil)
        let request = NetworkResponse(data: Data(), response: response, error: nil)
        switch request {
        case .success: XCTAssertTrue(true)
        default: XCTFail("Should have succeded")
        }
    }
    
    func test_success_onlyData() {
        let request = NetworkResponse(data: Data())
        switch request {
        case .success: XCTAssertTrue(true)
        default: XCTFail("Should have succeded")
        }
    }
}
