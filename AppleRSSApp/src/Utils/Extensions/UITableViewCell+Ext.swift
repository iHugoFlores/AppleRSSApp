//
//  UITableViewCell+Ext.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/13/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func animateSlideFromLeft() {
        self.frame.origin.x = -self.frame.width
        UIView.animate(
            withDuration: 0.7,
            delay: 0.2,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: .allowUserInteraction, animations: {
                self.frame.origin.x = 0
        }, completion: nil)
    }
}
