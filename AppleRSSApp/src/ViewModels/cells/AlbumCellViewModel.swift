//
//  AlbumCellViewModel.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class AlbumCellViewModel: BaseViewModel {
    var model: Album?

    var setImageHandler: ((Data) -> Void)?

    var albumImageData: Data? {
        didSet {
            guard let handler = setImageHandler else { return }
            guard let imageData = albumImageData else { return }
            DispatchQueue.main.async {
                handler(imageData)
            }
        }
    }
    
    init(networkHandler: NetworkInterface, model: Album) {
        super.init(networkHandler: networkHandler)
        self.model = model
    }
    
    func getAlbumDescription() -> (album: String, artist: String) {
        return (album: model?.name ?? "", artist: model?.artistName ?? "")
    }
    
    func getAlbumImage() {
        guard let imageUrl = model?.artworkUrl100 else { return }
        ItunesRSSAPI.getAlbumImage(interface: networkHandler, url: imageUrl) {[weak self] (response) in
            switch response.error {
            case .ok:
                self?.albumImageData = response.rawData
            default:
                self?.albumImageData = Data()
            }
        }
    }
}
