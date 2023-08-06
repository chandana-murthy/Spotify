//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    lazy var allButtons = [signupButton, googleButton, facebookButton, appleButton]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    private func setupButtons() {
        for button in allButtons {
            guard let button else {
                return
            }
            button.layer.cornerRadius = 15
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.borderWidth = 1
        }
    }
}

// MARK: - IBOutlets
extension WelcomeViewController {
    @IBAction func didTapNext() {
        let viewController = TabBarViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }
}
