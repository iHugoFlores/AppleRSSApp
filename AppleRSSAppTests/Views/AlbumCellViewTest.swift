//
//  AlbumCellViewTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/15/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class AlbumCellViewTest: XCTestCase {
    let album = Album(
        artistName: "The Artist",
        releaseDate: "1991-02-03",
        name: "My Album",
        copyright: "some copyright",
        artistUrl: "",
        artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/f2/5e/7c/f25e7cd1-aac9-2f16-e835-0f4124096ffd/20CRGIM20766.rgb.jpg/200x200bb.png",
        genres: [Genre(genreId: "", name: "", url: "")],
        url: "https://itunes.apple.com/us/genre/id15")

    func makeSUT() -> AlbumCellView {
        let view = AlbumCellView()
        return view
    }

    func test_initialState() {
        let albumCellSUT = makeSUT()
        XCTAssertEqual(albumCellSUT.contentView.subviews.count, 2)
    }
    
    func test_setUp() {
        let albumCellSUT = makeSUT()
        let networkHandler = MockNetwork()
        networkHandler.data = Data()
        let viewModel = AlbumCellViewModel(networkHandler: networkHandler, model: album)
        albumCellSUT.setUp(viewModel: viewModel)
        XCTAssertNotNil(viewModel.setImageHandler)
    }
}

