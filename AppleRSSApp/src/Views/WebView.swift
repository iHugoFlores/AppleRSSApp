//
//  WebView.swift
//  AppleRSSApp
//
//  Created by Hugo Flores Perez on 6/12/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIViewController {

    var request: URLRequest?
    
    private let spinnerView = Spinner()

    private let webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setUpViews()
    }
    
    private func setUpViews() {
        guard let request = request else { return }
        webView.navigationDelegate = self
        webView.addToAndFill(parent: view)
        webView.load(request)
        setActivityIndicatorState(isShowing: true)
    }
    
    func setActivityIndicatorState(isShowing: Bool) {
        isShowing ? spinnerView.presentOn(parent: view) : spinnerView.stop()
    }
}

extension WebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
        setActivityIndicatorState(isShowing: false)
    }
}
