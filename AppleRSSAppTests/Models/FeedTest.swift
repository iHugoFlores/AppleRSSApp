//
//  FeddTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class FeedTest: XCTestCase {
    func test_JSON_Parsing() {
        let bundle = Bundle(for: type(of: self))
        let result: Result<MainResponse, JSONUtilError> = JSONUtil.loadJSON(forBunle: bundle, resourceName: "FeedResponse")
        switch result {
        case .success:
            XCTAssert(true)
        case .failure(let error):
            XCTFail("The model did not parse the JSON successfully. \(error)")
        }
    }
}
