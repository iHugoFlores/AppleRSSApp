//
//  AlbumsListView.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class AlbumsListView: BaseView {
    
    private let viewModel: AlbumsListViewModel
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.rowHeight = 130
        return table
    }()
    
    init(viewModel: AlbumsListViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        setUpDataBinding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setUpDataBinding() {
        viewModel.reloadTableHandler = reloadAllTableData
    }
    
    private func reloadAllTableData() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainLayout()
        viewModel.getData()
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
        return viewModel.getNumberOfAlbums()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCellView.reuseIdentifier, for: indexPath) as? AlbumCellView
            else { fatalError("Couldn't cast to AlbumCellView") }
        let cellViewModel = viewModel.getCellViewmodelAt(indexPath: indexPath)
        cell.setUp(viewModel: cellViewModel)
        cell.animateSlideFromLeft()
        return cell
    }
}

extension AlbumsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.navigateToDetails(navigationController: navigationController, indexPath: indexPath)
    }
}
