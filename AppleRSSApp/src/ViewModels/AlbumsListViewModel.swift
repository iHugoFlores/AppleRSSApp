//
//  AlbumsListViewModel.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class AlbumsListViewModel: BaseViewModel {
    var reloadTableHandler: (() -> Void)?
    
    private var model: [AlbumCellViewModel] = [] {
        didSet {
            if let handler = reloadTableHandler { handler() }
        }
    }

    func getData() {
        isDataLoading = true
        ItunesRSSAPI.getFeed(interface: networkHandler) { [weak self] (response) in
            guard let self = self else { return }
            self.isDataLoading = false
            switch response {
            case .success(let data):
                self.model = data.feed.results.map { AlbumCellViewModel(networkHandler: self.networkHandler, model: $0) }
            case .failure:
                self.displayAlertMessage(title: "Download Error", body: "There was an error while downloading the feed", buttonMsg: "Try Again", callback: self.getData)
            }
        }
    }
    
    func getNumberOfAlbums() -> Int { model.count }
    
    func getCellViewmodelAt(indexPath: IndexPath) -> AlbumCellViewModel { model[indexPath.row] }

    func navigateToDetails(navigationController: NavigationInterface?, indexPath: IndexPath) {
        let result = model[indexPath.row]
        let viewModel = AlbumDetailsViewModel(networkHandler: networkHandler, model: result)
        let viewController = AlbumDetailsView(viewModel: viewModel)
        navigationController?.navigate(to: viewController)
    }
}
