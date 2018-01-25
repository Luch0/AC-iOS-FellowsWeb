//
//  WebViewController.swift
//  FellowsWeb
//
//  Created by Luis Calle on 1/25/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import SVProgressHUD

class WebViewController: UIViewController {
    
    private var urlRequest: URLRequest!

    // ideally this should be in its own view class
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let wv = WKWebView(frame: view.bounds, configuration: config)
        wv.navigationDelegate = self
        return wv
    }()
    
    init(urlRequest: URLRequest) {
        super.init(nibName: nil, bundle: nil)
        self.urlRequest = urlRequest
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.load(urlRequest)
        SVProgressHUD.show()
    }

}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}
