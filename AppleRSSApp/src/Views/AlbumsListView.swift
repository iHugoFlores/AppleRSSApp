//
//  AlbumsListView.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class AlbumsListView: BaseView {
    
    private var viewModel: AlbumsListViewModel?
    
    init(viewModel: AlbumsListViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel?.getData()
    }
}
