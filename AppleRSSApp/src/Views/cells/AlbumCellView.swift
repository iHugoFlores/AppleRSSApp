//
//  AlbumCellView.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class AlbumCellView: UITableViewCell {
    static let reuseIdentifier = "AlbumCellView"
    
    private var viewModel: AlbumCellViewModel?

    private let spinnerView = Spinner()

    private let albumImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.constraintTo(width: 120, height: 90)
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let mainContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpMainContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpDataBinding() {
        viewModel?.activityIndicatorHandler = setActivityIndicatorState(isShowing:)
        viewModel?.setImageHandler = setAlbumImage(imageData:)
    }

    private func setActivityIndicatorState(isShowing: Bool) {
        isShowing ? spinnerView.presentOn(parent: albumImage) : spinnerView.stop()
    }
    
    private func setAlbumImage(imageData: Data) {
        albumImage.image = UIImage(data: imageData)
    }

    private func setUpMainContainer() {
        mainContainer.addToAndFill(parent: contentView)
        mainContainer.addArrangedSubview(albumImage)
        mainContainer.addArrangedSubview(descriptionLabel)
    }
    
    func setUp(viewModel: AlbumCellViewModel) {
        self.viewModel = viewModel
        setInitialValues()
    }

    private func setInitialValues() {
        setUpDataBinding()
        viewModel?.getAlbumImage()
        setDescription()
    }
    
    private func setDescription() {
        let description = viewModel?.getAlbumDescription()
        let stringContent = NSMutableAttributedString(
            string: "\(description?.album ?? "")\n",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ])
        stringContent.append(NSAttributedString(
            string: "\(description?.artist ?? "")",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.gray,
        ]))
        descriptionLabel.attributedText = stringContent
    }
}
