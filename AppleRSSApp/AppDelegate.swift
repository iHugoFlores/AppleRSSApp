//
//  AppDelegate.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let urlSession = URLSession.shared
        let networkHandler = NetworkEngine(urlSession: urlSession)
        let viewModel = AlbumsListViewModel(networkHandler: networkHandler)
        window?.rootViewController = UINavigationController(rootViewController: AlbumsListView(viewModel: viewModel))
        window?.makeKeyAndVisible()
        return true
    }
}

