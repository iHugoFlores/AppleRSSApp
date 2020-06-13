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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpMainContainer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    private func setUpDataBinding() {
        viewModel?.activityIndicatorHandler = setActivityIndicatorState(isShowing:)
        viewModel?.setImageHandler = setAlbumImage(imageData:)
    }

    private func setActivityIndicatorState(isShowing: Bool) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            isShowing ? self.spinnerView.presentOn(parent: self.albumImage) : self.spinnerView.stop()
        }
    }
    
    private func setAlbumImage(imageData: Data) {
        DispatchQueue.main.async {[weak self] in
            let image = UIImage(data: imageData)
            self?.albumImage.image = image
        }
    }

    private func setUpMainContainer() {
        contentView.addSubview(albumImage)
        albumImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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
