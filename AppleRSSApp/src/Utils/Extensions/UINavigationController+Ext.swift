//
//  UINavigationController+Ext.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/13/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

extension UINavigationController: NavigationInterface {
    func navigate(to viewController: UIViewController) {
        self.pushViewController(viewController, animated: true)
    }
}
