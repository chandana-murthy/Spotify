//
//  HomeViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

enum HomeSection: CaseIterable {
    case newReleases
    case playlist
    case recommended
}

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.contentInsetAdjustmentBehavior = .never
    }

    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = Strings.browse
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.settings, style: .done, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }

    private func setupCollectionView() {
        self.collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(PlaylistCollectionViewCell.nib(), forCellWithReuseIdentifier: PlaylistCollectionViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        configureLayout()
    }

    func configureLayout() {
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            self.createLayoutForSection(HomeSection.allCases[sectionIndex])
        }
    }

    private func createLayoutForSection(_ section: HomeSection) -> NSCollectionLayoutSection {
        switch section {
        case .newReleases:
            return createNewReleasesLayout()
        case .playlist:
            return createPlaylistLayout()
        case .recommended:
            return createRecommendedLayout()
        }
    }

    private func createPlaylistLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(200),
                heightDimension: .absolute(200))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let verGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(200),
                heightDimension: .absolute(400)
            ),
            repeatingSubitem: item,
            count: 2
        )
        let horGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(200),
                heightDimension: .absolute(400)
            ),
            repeatingSubitem: verGroup,
            count: 1
        )

        let section = NSCollectionLayoutSection(group: horGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func defaultSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.2))

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 1)

        let section = NSCollectionLayoutSection(group: group)
        return section
    }


    private func createNewReleasesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let verGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.33)
            ),
            repeatingSubitem: item,
            count: 3
        )
        let horGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.6)
            ),
            repeatingSubitem: verGroup,
            count: 1
        )

        let section = NSCollectionLayoutSection(group: horGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func createRecommendedLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        return section
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 21
        case 1:
            return 12
        case 2:
            return 4
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistCollectionViewCell.cellIdentifier, for: indexPath) as? PlaylistCollectionViewCell else {
            fatalError("Collection view cell not configured properly")
        }
        cell.setCellTitle(String(indexPath.item + 1))
        switch indexPath.section {
        case 0 :
            cell.backgroundColor = .systemPink
        case 1:
            cell.backgroundColor = .systemBlue
        case 2:
            cell.backgroundColor = .purple
        default:
            break
        }

        return cell
    }

}
