//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class ProfileViewController: UIViewController {
    var viewModel: ProfileViewModel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var followCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        bind()
        fetchCurrentUserDetails()
        imageView.rounden(border: true, borderColor: .white)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGradientBackground()
    }

    func setGradientBackground() {
        let colorTop =  UIColor.gradientTopColor.cgColor
        let colorBottom = UIColor.gradientBottomColor.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = gradientView.bounds

        gradientView.clipsToBounds = true
        gradientView.layer.insertSublayer(gradientLayer, at:0)
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
            let followersTotal = userProfile.followers.total
            DispatchQueue.main.async {
                self?.displayNameLabel.text = userProfile.display_name
                self?.emailLabel.text = userProfile.email
                self?.followCountLabel.text = String(followersTotal ?? 0)
                self?.planLabel.text = userProfile.product
//                self?.imageView.image = userProfile.images?.first?.url
            }
        }

        viewModel.didFetchProfileFail = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlertWithDismiss(message: error.localizedDescription)
            }
        }
    }
}
