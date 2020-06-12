//
//  AlbumsListViewModel.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation
import UIKit.UINavigationController

class AlbumsListViewModel: BaseViewModel {
    var reloadTableHandler: (() -> Void)?
    
    private var model: [AlbumCellViewModel] = [] {
        didSet {
            guard let handler = reloadTableHandler else { return }
            DispatchQueue.main.async { handler() }
        }
    }

    func getData() {
        isDataLoading = true
        ItunesRSSAPI.getFeed(interface: networkHandler) { [weak self] (response) in
            self?.isDataLoading = false
            switch response.error {
            case .ok:
                guard let data = response.data?.feed.results, let networkHandler = self?.networkHandler else { return }
                self?.model = data.map { AlbumCellViewModel(networkHandler: networkHandler, model: $0) }
            default:
                guard let handler = self?.presentAlertHandler else { return }
                DispatchQueue.main.async {
                    handler("Download Error", "There was an error while downloading the feed", "Try Again", self?.getData)
                }
            }
        }
    }
    
    func getNumberOfAlbums() -> Int { model.count }
    
    func getCellViewmodelAt(indexPath: IndexPath) -> AlbumCellViewModel {
        model[indexPath.row]
    }

    func navigateToDetails(navigationController: UINavigationController?, indexPath: IndexPath) {
        let result = model[indexPath.row]
        let viewModel = AlbumDetailsViewModel(networkHandler: networkHandler, model: result)
        let viewController = AlbumDetailsView(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
