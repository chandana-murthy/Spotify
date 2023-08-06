//
//  TabBarViewModel.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

class TabBarViewModel {
    func getHomeViewModel() -> HomeViewModel {
        HomeViewModel()
    }

    func getSearchViewModel() -> SearchViewModel {
        SearchViewModel()
    }

    func getLibraryViewModel() -> LibraryViewModel {
        LibraryViewModel()
    }
}
