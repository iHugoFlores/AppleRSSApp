//
//  UIView+Ext.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

extension UIView {
    private func addToParentAndActivateAutolayout(parent: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
    }

    func addToAndFill(parent: UIView) {
        addToParentAndActivateAutolayout(parent: parent)
        let margins = parent.layoutMarginsGuide
        self.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

    func addToAndCenter(parent: UIView) {
        addToParentAndActivateAutolayout(parent: parent)
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
    }
    
    func constraintTo(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: height)
        heightConstraint.isActive = true
    }
}
