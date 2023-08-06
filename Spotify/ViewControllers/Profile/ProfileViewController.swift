//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class ProfileViewController: UIViewController {
    var viewModel: ProfileViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        bind()
        fetchCurrentUserDetails()
    }

    private func fetchCurrentUserDetails() {
        viewModel.getCurrentUserData()
    }

    private func setupNavBar() {
        self.title = Strings.profile
        navigationController?.navigationBar.titleTextAttributes = Constants.titleColorKey
    }

    private func bind() {
        viewModel.didFetchProfileSucceed = { [weak self] userProfile in
            let userName = userProfile.display_name
            let email = userProfile.email
            let followersTotal = userProfile.followers.total
            print(userProfile)
        }

        viewModel.didFetchProfileFail = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlertWithDismiss(message: error.localizedDescription)
            }
        }
    }
}
