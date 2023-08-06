//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapNext() {
        let viewController = TabBarViewController()
        navigationController?.pushViewController(viewController, animated: false)
    }
}
