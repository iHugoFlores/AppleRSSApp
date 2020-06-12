//
//  BaseViewView.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/11/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class BaseView: UIViewController {
    
    private var baseViewModel: BaseViewModel?
    
    private let spinnerView = Spinner()
    
    init(viewModel: BaseViewModel) {
        super.init(nibName: nil, bundle: nil)
        baseViewModel = viewModel
        setUpBaseDataBinding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUpBaseDataBinding() {
        baseViewModel?.activityIndicatorHandler = setActivityIndicatorState(isShowing:)
        baseViewModel?.presentAlertHandler = displayAlert(title:message:buttonMessage:callback:)
    }
    
    func setActivityIndicatorState(isShowing: Bool) {
        isShowing ? spinnerView.presentOn(parent: view) : spinnerView.stop()
    }
    
    private func displayAlert(title: String, message: String, buttonMessage: String, callback: (() -> Void)?) {
        let handler = { (action: UIAlertAction) in
            if let callback = callback { callback() }
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonMessage, style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
}
