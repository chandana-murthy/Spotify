//
//  ErrorManager.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

enum SError: Error {
    case unknownError
    case invalidAPIToken
    case failedToGetData

    var rawValue: String? {
        switch self {
        case .invalidAPIToken:
            return Strings.invalidAPIToken
        case .unknownError:
            return Strings.thereWasError
        case .failedToGetData:
            return "Failed to get data"
        }
    }
}
