//
//  SearchViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }

    private func configureNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = Strings.search
    }
}
