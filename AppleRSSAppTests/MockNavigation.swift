//
//  MockNavigation.swift
//  AppleRSSAppTests
//
//  Created by Hugo Flores Perez on 6/13/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit
@testable import AppleRSSApp

class MockNavigation: NavigationInterface {
    private var navigationExecuted = false
    func navigate(to viewController: UIViewController) {
        navigationExecuted = true
    }
    func wasNavigationExecuted() -> Bool { navigationExecuted }
}
