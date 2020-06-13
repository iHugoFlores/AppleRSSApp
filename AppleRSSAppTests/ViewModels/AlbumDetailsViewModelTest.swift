//
//  AlbumDetailsViewModelTest.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/13/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import AppleRSSApp

class AlbumDetailsViewModelTest: XCTestCase {
    let album = Album(
        artistName: "The Artist",
        releaseDate: "1991-02-03",
        name: "My Album",
        copyright: "some copyright",
        artistUrl: "",
        artworkUrl100: "https://is4-ssl.mzstatic.com/image/thumb/Music113/v4/f2/5e/7c/f25e7cd1-aac9-2f16-e835-0f4124096ffd/20CRGIM20766.rgb.jpg/200x200bb.png",
        genres: [Genre(genreId: "", name: "1", url: ""), Genre(genreId: "", name: "2", url: "")],
        url: "https://itunes.apple.com/us/genre/id15")

    func test_getAlbumName() {
        let model = AlbumCellViewModel(networkHandler: MockNetwork(), model: album)
        let viewModel = AlbumDetailsViewModel(networkHandler: MockNetwork(), model: model)
        let albumName = viewModel.getAlbumName()
        XCTAssertEqual(albumName, album.name)
    }
    
    func test_getAlbumImageData() {
        guard let testData: Data = "Test Data".data(using: .utf8) else { fatalError() }
        let model = AlbumCellViewModel(networkHandler: MockNetwork(), model: album)
        model.albumImageData = testData
        let viewModel = AlbumDetailsViewModel(networkHandler: MockNetwork(), model: model)
        let imageData = viewModel.getAlbumImageData()
        XCTAssertEqual(imageData, testData)
    }
    
    func test_getAlbumDescription() {
        let model = AlbumCellViewModel(networkHandler: MockNetwork(), model: album)
        let viewModel = AlbumDetailsViewModel(networkHandler: MockNetwork(), model: model)
        let (albumName, artist, genre, releaseDate, copyRight) = viewModel.getAlbumDescription()
        XCTAssertEqual(albumName, album.name)
        XCTAssertEqual(artist, album.artistName)
        XCTAssertEqual(genre, album.genres.map { $0.name }.joined(separator: ", "))
        XCTAssertEqual(releaseDate, DateUtil.apiDateToMediumDate(album.releaseDate))
        XCTAssertEqual(copyRight, album.copyright)
    }
    
    func test_navigateToWebView() {
        let model = AlbumCellViewModel(networkHandler: MockNetwork(), model: album)
        let viewModel = AlbumDetailsViewModel(networkHandler: MockNetwork(), model: model)
        let mockNavigation = MockNavigation()
        viewModel.navigateToWebView(navigationController: mockNavigation)
        XCTAssertTrue(mockNavigation.wasNavigationExecuted())
    }
}
