//
//  AlbumDetailsViewModel.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class AlbumDetailsViewModel: BaseViewModel {
    private var model: AlbumCellViewModel
    
    init(networkHandler: NetworkInterface, model: AlbumCellViewModel) {
        self.model = model
        super.init(networkHandler: networkHandler)
    }
    
    func getAlbumName() -> String { model.model.name }
    
    func getAlbumImageData() -> Data? { model.albumImageData }
    
    func getAlbumDescription() -> (albumName: String, artist: String, genre: String, releaseDate: String, copyRight: String) {
        let (album, artist) = model.getAlbumDescription()
        return (
            albumName: album,
            artist: artist,
            genre: model.model.genres.map { $0.name }.joined(separator: ", "),
            releaseDate: DateUtil.apiDateToMediumDate(model.model.releaseDate),
            copyRight: model.model.copyright
        )
    }
    
    func navigateToWebView(navigationController: NavigationInterface?) {
        guard let itunesUrl = URL(string: model.model.url) else { fatalError() }
        let request = URLRequest(url: itunesUrl)
        let viewController = WebView()
        viewController.request = request
        navigationController?.navigate(to: viewController)
    }
}
