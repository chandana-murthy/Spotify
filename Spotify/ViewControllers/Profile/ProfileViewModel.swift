//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

class ProfileViewModel {
    var didFetchProfileSucceed: ((UserProfile) -> Void)?
    var didFetchProfileFail: ((Error) -> Void)?

    func getCurrentUserData() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let userProfile):
                self?.didFetchProfileSucceed?(userProfile)
                break
            case .failure(let error):
                self?.didFetchProfileFail?(error)
                break
            }
        }
    }
}
