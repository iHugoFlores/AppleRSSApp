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
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        // label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    private let mainContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        //view.isLayoutMarginsRelativeArrangement = true
        //view.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
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
        let description = viewModel?.getAlbumDescription()
        descriptionLabel.text = "\(description?.album ?? "")\n\(description?.artist ?? "")"
        viewModel?.getAlbumImage()
    }
}
