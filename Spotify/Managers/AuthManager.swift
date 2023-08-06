//
//  AuthManager.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    private init() { }

    var isSignedIn: Bool {
        return true
    }

    private var accessToken: String? {
        return nil
    }
    private var refreshToken: String? {
        return nil
    }
    private var tokenExpirationDate: String? {
        return nil
    }

    private var shouldRefreshTocken: Bool {
        return false
    }
}
