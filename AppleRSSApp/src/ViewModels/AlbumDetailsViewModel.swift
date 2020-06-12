//
//  AlbumDetailsViewModel.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation
import UIKit.UINavigationController

class AlbumDetailsViewModel: BaseViewModel {
    private var model: AlbumCellViewModel?
    
    init(networkHandler: NetworkInterface, model: AlbumCellViewModel) {
        super.init(networkHandler: networkHandler)
        self.model = model
    }
    
    func getAlbumName() -> String { model?.model?.name ?? "" }
    
    func getAlbumImageData() -> Data? { model?.albumImageData }
    
    func getAlbumDescription() -> (albumName: String, artist: String, genre: [String], releaseDate: String, copyRight: String) {
        guard let model = model else { fatalError("No model") }
        let (album, artist) = model.getAlbumDescription()
        return (
            albumName: album,
            artist: artist,
            genre: model.model?.genres.map { $0.name } ?? [],
            releaseDate: model.model?.releaseDate ?? "",
            copyRight: model.model?.copyright ?? ""
        )
    }
    
    func navigateToWebView(navigationController: UINavigationController?) {
        guard
            let model = model?.model,
            let itunesUrl = URL(string: model.url)
            else { fatalError() }
        let request = URLRequest(url: itunesUrl)
        let viewController = WebView()
        viewController.request = request
        navigationController?.pushViewController(viewController, animated: true)
    }
}
