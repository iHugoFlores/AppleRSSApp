//
//  AlbumCellViewModel.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class AlbumCellViewModel: BaseViewModel {
    var model: Album

    var setImageHandler: ((Data) -> Void)?

    var albumImageData: Data? {
        didSet {
            guard let handler = setImageHandler else { return }
            guard let imageData = albumImageData else { return }
            handler(imageData)
        }
    }
    
    init(networkHandler: NetworkInterface, model: Album) {
        self.model = model
        super.init(networkHandler: networkHandler)
    }
    
    func getAlbumDescription() -> (album: String, artist: String) {
        return (album: model.name, artist: model.artistName)
    }
    
    func getAlbumImage() {
        isDataLoading = true
        ItunesRSSAPI.getAlbumImage(interface: networkHandler, url: model.artworkUrl100) {[weak self] (response) in
            guard let self = self else { return }
            self.isDataLoading = false
            switch response {
            case .success(let data):
                self.albumImageData = data
            case .failure:
                self.albumImageData = Data()
            }
        }
    }
}
