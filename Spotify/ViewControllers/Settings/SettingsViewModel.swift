//
//  SettingsViewModel.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

struct SettingsSection {
    let title: String
    let options: [Option]
}

struct Option {
    let text: String
    let handler: () -> Void
    let image: String
}

class SettingsViewModel {
    func getProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
}
