//
//  APICaller.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()

    private init() { }

    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        
    }
}
