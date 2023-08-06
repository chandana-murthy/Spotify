//
//  AuthViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavView()
        setupWebView()
    }

    var completionHandler: ((Bool, Error?) -> Void)?

    private func setupWebView() {
        let pref = WKWebpagePreferences()
        pref.allowsContentJavaScript = true
        webView.configuration.applicationNameForUserAgent = Constants.latestWebAgent
        webView.configuration.defaultWebpagePreferences = pref
        webView.navigationDelegate = self
        guard let url = AuthManager.shared.signInUrl else {
            return
        }
        webView.load(URLRequest(url: url))
    }

    private func setupNavView() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        let colorKey = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = colorKey
        self.title = Strings.login
    }
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?.first(where: { $0.name == "code"})?.value else {
            print("This failed")
            return
        }
        print("code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success, error in
            DispatchQueue.main.async {
                self?.completionHandler?(success, error)
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
