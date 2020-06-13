//
//  AlbumCellViewModelTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class AlbumCellViewModelTest: XCTestCase {
    let album = Album(
        artistName: "The Artist",
        releaseDate: "1991-02-03",
        name: "My Album",
        copyright: "some copyright",
        artistUrl: "",
        artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/f2/5e/7c/f25e7cd1-aac9-2f16-e835-0f4124096ffd/20CRGIM20766.rgb.jpg/200x200bb.png",
        genres: [Genre(genreId: "", name: "", url: "")],
        url: "https://itunes.apple.com/us/genre/id15")
    
    func test_getAlbumDescription() {
        let viewModel = AlbumCellViewModel(networkHandler: MockNetwork(), model: album)
        let (albumVal, artistVal) = viewModel.getAlbumDescription()
        XCTAssertEqual(albumVal, album.name)
        XCTAssertEqual(artistVal, album.artistName)
    }
    
    func test_albumImageData_binder() {
        guard let testData: Data = "Test Data".data(using: .utf8) else { fatalError() }
        let viewModel = AlbumCellViewModel(networkHandler: MockNetwork(), model: album)
        var imageHandlerCalled = false
        let imageHandler = { (data: Data) in imageHandlerCalled = true }
        viewModel.setImageHandler = imageHandler
        viewModel.albumImageData = testData
        XCTAssertTrue(imageHandlerCalled)
    }

    func test_albumImageData_noBinder() {
        guard let testData: Data = "Test Data".data(using: .utf8) else { fatalError() }
        let viewModel = AlbumCellViewModel(networkHandler: MockNetwork(), model: album)
        viewModel.albumImageData = testData
        XCTAssertEqual(viewModel.albumImageData, testData)
    }
    
    func test_albumImageData_nilData() {
        let viewModel = AlbumCellViewModel(networkHandler: MockNetwork(), model: album)
        var imageHandlerCalled = false
        let imageHandler = { (data: Data) in imageHandlerCalled = true }
        viewModel.setImageHandler = imageHandler
        viewModel.albumImageData = nil
        XCTAssertFalse(imageHandlerCalled)
    }
    
    func test_getAlbumImage() {
        guard let testData: Data = "Test Data".data(using: .utf8) else { fatalError() }
        let networkHandler = MockNetwork()
        networkHandler.data = testData
        let viewModel = AlbumCellViewModel(networkHandler: networkHandler, model: album)
        viewModel.getAlbumImage()
        XCTAssertEqual(viewModel.albumImageData, testData)
    }

    func test_getAlbumImage_fail() {
        guard let testData: Data = "Test Data".data(using: .utf8) else { fatalError() }
        let networkHandler = MockNetwork()
        networkHandler.error = .noDataForParsing
        let viewModel = AlbumCellViewModel(networkHandler: networkHandler, model: album)
        viewModel.getAlbumImage()
        XCTAssertNotEqual(viewModel.albumImageData, testData)
    }
}
