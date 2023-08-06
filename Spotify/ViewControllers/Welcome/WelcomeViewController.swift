//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        authorizeUser()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func authorizeUser() {
        if AuthManager.shared.isSignedIn {
            let tabController = TabBarViewController()
            tabController.modalPresentationStyle = .fullScreen
            self.present(tabController, animated: false)
        }
    }

    private func setupButtons() {
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderColor = UIColor.gray.cgColor
        loginButton.layer.borderWidth = 1
    }

    private func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

// MARK: - IBOutlets
extension WelcomeViewController {
    @IBAction func didTapLogin() {
        showLoading()
        let vc = UIViewController.authViewController { [weak self] success, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self?.hideLoading()
                    self?.showErrorAlertWithDismiss(message: error?.localizedDescription ?? Strings.thereWasError)
                }
                return
            }
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    private func handleSignIn(success: Bool) {
        guard success else {
            self.showErrorAlertWithDismiss(message: Strings.errorWhileLoggingIn)
            return
        }
        self.hideLoading()
        let tabController = TabBarViewController()
        tabController.modalPresentationStyle = .fullScreen
        self.present(tabController, animated: true)
    }
}
