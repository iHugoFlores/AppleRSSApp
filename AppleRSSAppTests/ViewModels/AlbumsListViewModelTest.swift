//
//  AlbumsListViewModelTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/13/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class AlbumsListViewModelTest: XCTestCase {

    func test_reloadTableHandler() {
        let networkHandler = MockNetwork()
        let bundle = Bundle(for: type(of: self))
        let localMockData = JSONUtil.load(forBunle: bundle, resourceName: "FeedResponse")
        switch localMockData {
        case .success(let data):
            networkHandler.data = data
        default:
            XCTFail("Could not load mock data")
            return
        }
        let viewModel = AlbumsListViewModel(networkHandler: networkHandler)
        var reloadTableCalled = false
        let reloadHandler = { reloadTableCalled = true }
        viewModel.reloadTableHandler = reloadHandler
        viewModel.getData()
        XCTAssertTrue(reloadTableCalled)
        XCTAssertEqual(viewModel.getCellViewmodelAt(indexPath: IndexPath(row: 0, section: 0)).model.name, "Shape & Destroy")
    }
    
    func test_reloadTableHandler_failed() {
        let networkHandler = MockNetwork()
        networkHandler.error = .unexpected
        let viewModel = AlbumsListViewModel(networkHandler: networkHandler)
        var alertHandlerCalled = false
        let alertHandler = {(_: String, _: String, _: String, _: (() -> Void)?) in alertHandlerCalled = true }
        viewModel.presentAlertHandler = alertHandler
        viewModel.getData()
        XCTAssertTrue(alertHandlerCalled)
    }
    
    func test_navigateToDetails() {
        let networkHandler = MockNetwork()
        let bundle = Bundle(for: type(of: self))
        let localMockData = JSONUtil.load(forBunle: bundle, resourceName: "FeedResponse")
        switch localMockData {
        case .success(let data):
            networkHandler.data = data
        default:
            XCTFail("Could not load mock data")
            return
        }
        let viewModel = AlbumsListViewModel(networkHandler: networkHandler)
        viewModel.getData()
        let mockNavigation = MockNavigation()
        viewModel.navigateToDetails(navigationController: mockNavigation, indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockNavigation.wasNavigationExecuted())
    }
}
