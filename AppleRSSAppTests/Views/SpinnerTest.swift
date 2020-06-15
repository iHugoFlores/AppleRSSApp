//
//  SpinnerTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/15/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class SpinnerTest: XCTestCase {
    func makeSUT() -> Spinner {
        let view = Spinner()
        return view
    }

    func test_initialState() {
        let spinnerSUT = makeSUT()
        XCTAssertNil(spinnerSUT.superview)
    }

    func test_displaysOnView_andStop() {
        let spinnerSUT = makeSUT()
        spinnerSUT.stop()
        let testView = UIView()
        spinnerSUT.presentOn(parent: testView)
        XCTAssertEqual(spinnerSUT.superview, testView)
        spinnerSUT.stop()
        XCTAssertNil(spinnerSUT.superview)
    }
}
