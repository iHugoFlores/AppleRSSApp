//
//  WebViewTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/15/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class WebViewTest: XCTestCase {
    let urlRequest: URLRequest = {
        guard let url = URL(string: "https://www.google.com/") else { fatalError("Endpoint URL error") }
        return URLRequest(url: url)
    }()

    func makeSUT() -> WebView {
        let view = WebView()
        return view
    }

    func test_initialState() {
        let webSUT = makeSUT()
        XCTAssertTrue(webSUT.view.subviews.isEmpty)
    }
    
    func test_presentSpinner() {
        let webSUT = makeSUT()
        webSUT.request = urlRequest
        XCTAssertFalse(webSUT.view.subviews.isEmpty)
    }
}
