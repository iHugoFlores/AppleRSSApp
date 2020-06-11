//
//  BaseViewModel.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class BaseViewModel {
    internal let networkHandler: NetworkInterface

    internal var isDataLoading: Bool = false {
        didSet {
            if oldValue == isDataLoading { return }
            guard let handler = activityIndicatorHandler else { return }
            DispatchQueue.main.async { [weak self] in
                handler(self?.isDataLoading ?? false)
            }
        }
    }
    var activityIndicatorHandler: ((Bool) -> Void)?
    var presentAlertHandler: ((String, String, String, (() -> Void)?) -> Void)?

    init(networkHandler: NetworkInterface) {
        self.networkHandler = networkHandler
    }

    internal func displayAlertMessage(title: String, body: String, buttonMsg: String, callback: (() -> Void)? = nil) {
        guard let handler = presentAlertHandler else { return }
        handler(title, body, buttonMsg, callback)
    }
}
