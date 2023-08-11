//
//  HomeViewModel.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

class HomeViewModel {
    var didFetchNewReleasesSucceed: ((NewReleases) -> Void)?
    var didFetchNewReleasesFail: ((Error) -> Void)?
    var didFetchPlaylistsSucceed: ((Playlists) -> Void)?
    var didFetchPlaylistsFail: ((Error) -> Void)?
    var didFetchGenresSucceed: ((Genres) -> Void)?
    var didFetchGenresFail: ((Error) -> Void)?
    var didFetchRecommendationsSucceed: ((Recommendations) -> Void)?
    var didFetchRecommendationssFail: ((Error) -> Void)?

    func getSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel()
    }

    func fetchNewReleases() {
        APICaller.shared.getNewReleases() { [weak self] result in
            switch result {
            case .success(let newReleases):
                self?.didFetchNewReleasesSucceed?(newReleases)
                break
            case .failure(let error):
                self?.didFetchNewReleasesFail?(error)
                break
            }
        }
    }

    func fetchFeaturedPlaylists() {
        APICaller.shared.getFeaturedPlaylists() { [weak self] result in
            switch result {
            case .success(let playlists):
                self?.didFetchPlaylistsSucceed?(playlists.playlists)
                break
            case .failure(let error):
                self?.didFetchPlaylistsFail?(error)
                break
            }
        }
    }

    func fetchRecommendedGenres() {
        APICaller.shared.getRecommendedGenres() { [weak self] result in
            switch result {
            case .success(let genres):
                self?.didFetchGenresSucceed?(genres)
                let allGenres = genres.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let randomGenre = allGenres.randomElement() {
                        seeds.insert(randomGenre)
                    }
                }
                self?.fetchRecommendedTracks(seeds: seeds)
                break

            case .failure(let error):
                self?.didFetchGenresFail?(error)
                break
            }
        }
    }

    func fetchRecommendedTracks(seeds: Set<String>) {
        APICaller.shared.getRecommendations(genres: seeds) { [weak self] result in
            switch result {
            case .success(let recommendations):
                self?.didFetchRecommendationsSucceed?(recommendations)
                break

            case .failure(let error):
                self?.didFetchRecommendationssFail?(error)
                break

            }
        }
    }
}
