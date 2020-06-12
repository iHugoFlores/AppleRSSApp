//
//  AlbumDetailsView.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class AlbumDetailsView: BaseView {
    
    private var viewModel: AlbumDetailsViewModel?
    
    private let albumImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let itunesButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("See in Itunes", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    init(viewModel: AlbumDetailsViewModel) {
        super.init(viewModel: viewModel)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainLayout()
        setUpInitialValues()
    }
    
    private func setUpMainLayout() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .systemBackground
        view.addSubview(albumImage)
        albumImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        albumImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        albumImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        albumImage.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 8).isActive = true
        
        view.addSubview(itunesButton)
        itunesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        itunesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        itunesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        itunesButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20).isActive = true
        
        let fastTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        fastTapGesture.numberOfTapsRequired = 2
        itunesButton.addGestureRecognizer(fastTapGesture)
    }
    
    private func setUpInitialValues() {
        guard let viewModel = viewModel else { return }
        albumImage.image = UIImage(data: viewModel.getAlbumImageData() ?? Data())
        setDescription()
    }

    private func setDescription() {
        guard let viewModel = viewModel else { return }
        let description = viewModel.getAlbumDescription()
        let stringContent = NSMutableAttributedString(
            string: "\(description.albumName)\n",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)
        ])
        stringContent.append(NSAttributedString(
            string: "\(description.artist)\n",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.gray,
        ]))
        stringContent.append(NSAttributedString(
            string: "\(description.releaseDate)\n",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.gray,
        ]))
        stringContent.append(NSAttributedString(
            string: "\(description.genre)\n",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
        ]))
        stringContent.append(NSAttributedString(
            string: "\(description.copyRight)",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: UIColor.systemGray3,
        ]))
        descriptionLabel.attributedText = stringContent
    }

    @objc func doubleTapped(sender: UIButton) {
        viewModel?.navigateToWebView(navigationController: navigationController)
    }
}
