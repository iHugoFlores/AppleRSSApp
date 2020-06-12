//
//  DateUtilTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class DateUtilTest: XCTestCase {
    func test_apiDateToMediumDate() {
        let testDate = "2012-01-01"
        let expected = "Jan 1, 2012"
        let result = DateUtil.apiDateToMediumDate(testDate)
        XCTAssertEqual(result, expected)
    }
}
