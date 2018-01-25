//
//  DetailViewController.swift
//  Fellows
//
//  Created by Alex Paul on 1/5/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    private var fellow: Fellow!
    
    private var sfSafariVC: SFSafariViewController!
    
    init(fellow: Fellow, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.fellow = fellow
        detailView.configureDetailView(fellow: fellow, image: image)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(detailView)
        detailView.safariLinkButton.addTarget(self, action: #selector(launchSafari), for: .touchUpInside)
        detailView.webViewLinkButton.addTarget(self, action: #selector(showWebView), for: .touchUpInside)
        detailView.gitHubLinkButton.addTarget(self, action: #selector(showSFSafariVC), for: .touchUpInside)
        configureNavBar()
    }
    
    // Presenting Web Content (Method 1) - via Safari
    // downside: user taken away from the app, may not return
    @objc private func launchSafari() {
        UIApplication.shared.open(URL(string: "https://developer.apple.com/documentation")!, options: [:]) { (done) in
            print("Safari launched")
        }
    }
    
    // Presenting Web Content (Method 2) - via MKWebView
    // advantages: developer is able to customize UI
    // disadvantages: you don't access to the Apple's keychain,
    // so the user's credentials is not available
    @objc private func showWebView() {
        let urlRequest = URLRequest(url: URL(string: "https://www.c4q.nyc")!)
        let webViewController = WebViewController(urlRequest: urlRequest)
        navigationController?.pushViewController(webViewController, animated: true)
        print("WebView launched")
    }
    
    // Presenting Web Content (Method 3) - via SFSaafariViewController
    // advantages: all the benefits of safari, e.g Apple keychain access
    //             security note: developers don't have access to user information
    //             * users stay within your app
    //             * third party authentication via (Oauth) e.g login with Facebook
    // disadvantages: n/a
    @objc private func showSFSafariVC() {
        sfSafariVC = SFSafariViewController(url: fellow.githubURL)
        navigationController?.pushViewController(sfSafariVC, animated: true)
    }
    
    private func configureNavBar() {
        navigationItem.title = "\(fellow.name)"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // scroll to top of text view
        let range = NSRangeFromString(detailView.bioTextView.text)
        detailView.bioTextView.scrollRangeToVisible(range)
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

}
