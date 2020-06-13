//
//  BaseViewView.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class BaseView: UIViewController {

    private let baseViewModel: BaseViewModel

    private let spinnerView = Spinner()
    
    init(viewModel: BaseViewModel) {
        baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setUpBaseDataBinding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUpBaseDataBinding() {
        baseViewModel.activityIndicatorHandler = setActivityIndicatorState(isShowing:)
        baseViewModel.presentAlertHandler = displayAlert(title:message:buttonMessage:callback:)
    }
    
    func setActivityIndicatorState(isShowing: Bool) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            isShowing ? self.spinnerView.presentOn(parent: self.view) : self.spinnerView.stop()
        }
    }
    
    private func displayAlert(title: String, message: String, buttonMessage: String, callback: (() -> Void)?) {
        let handler = { (action: UIAlertAction) in
            if let callback = callback { callback() }
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonMessage, style: .default, handler: handler))
        DispatchQueue.main.async {[weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
