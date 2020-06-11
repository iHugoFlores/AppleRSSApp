//
//  AlbumsListViewModel.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class AlbumsListViewModel: BaseViewModel {
    private var model: [Result] = []

    func getData() {
        isDataLoading = true
        ItunesRSSAPI.getFeed(interface: networkHandler) { [weak self] (response) in
            switch response.error {
            case .ok:
                guard let data = response.data?.feed.results else { return }
                self?.model = data
                self?.isDataLoading = false
            default: print("Some error happened", response.response, response.error)
            }
        }
    }
}
