//
//  HomeViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        viewModel.fetchRecommendedGenres()
    }

    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = Strings.browse
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.settings, style: .done, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }

    @objc private func didTapSettings() {
        let viewModel = viewModel.getSettingsViewModel()
        let viewController = UIViewController.settingsController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func bind() {
        viewModel.didFetchNewReleasesFail = { [weak self] error in

        }

        viewModel.didFetchNewReleasesSucceed = { [weak self] newReleases in
            print(newReleases)
        }

        viewModel.didFetchPlaylistsSucceed = { playlists in

        }

        viewModel.didFetchPlaylistsFail = { error in

        }
    }
}
