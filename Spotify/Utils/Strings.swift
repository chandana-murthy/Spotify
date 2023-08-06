//
//  Strings.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

struct Strings {
    static let register = NSLocalizedString("Register", comment: "")
    static let login = NSLocalizedString("Login", comment: "")
    static let logout = NSLocalizedString("Logout", comment: "")
    static let home = NSLocalizedString("Home", comment: "")
    static let search = NSLocalizedString("Search", comment: "")
    static let library = NSLocalizedString("Library", comment: "")
    static let yourLibrary = NSLocalizedString("Your Library", comment: "")
    static let playlist = NSLocalizedString("Playlist", comment: "")
    static let artist = NSLocalizedString("Artist", comment: "")
    static let browse = NSLocalizedString("Browse", comment: "")
    static let ok = NSLocalizedString("Okay", comment: "")
    static let dismiss = NSLocalizedString("Dismiss", comment: "")
    static let alert = NSLocalizedString("Alert!", comment: "")
    static let error = NSLocalizedString("Error!", comment: "")
    static let account = NSLocalizedString("Account", comment: "")
    static let profile = NSLocalizedString("Profile", comment: "")
    static let settings = NSLocalizedString("Settings", comment: "")
    static let viewProfile = NSLocalizedString("View your profile", comment: "")
}

// MARK: - Long Strings
extension Strings {
    static let thereWasError = NSLocalizedString("There was an error. Please try again later", comment: "")
    static let invalidAPIToken = NSLocalizedString("Invalid API Token. Please contact the developer", comment: "")
    static let errorWhileLoggingIn = NSLocalizedString("Something went wrong while logging in. Please try again", comment: "")

}
