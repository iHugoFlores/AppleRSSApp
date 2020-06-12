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
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 10
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    init(viewModel: AlbumsListViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
        setUpDataBinding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpDataBinding() {
        viewModel?.reloadTableHandler = tableView.reloadData
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainLayout()
        viewModel?.getData()
    }
    
    private func setUpMainLayout() {
        title = "Itunes RSS"
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AlbumCellView.self, forCellReuseIdentifier: AlbumCellView.reuseIdentifier)
        tableView.addToAndFill(parent: view)
    }
}

extension AlbumsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfAlbums() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCellView.reuseIdentifier, for: indexPath) as? AlbumCellView
            else { fatalError("Couldn't cast to AlbumCellView") }
        guard let cellViewModel = viewModel?.getCellViewmodelAt(indexPath: indexPath) else { fatalError("No view model for cell") }
        cell.setUp(viewModel: cellViewModel)
        cell.frame.origin.x = -cell.frame.width
        UIView.animate(
            withDuration: 0.7,
            delay: 0.2,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: .allowUserInteraction, animations: {
                cell.frame.origin.x = 0
        }, completion: nil)
        return cell
    }
}

extension AlbumsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.navigateToDetails(navigationController: navigationController, indexPath: indexPath)
    }
}
