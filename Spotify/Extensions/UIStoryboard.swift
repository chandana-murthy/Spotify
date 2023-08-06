//
//  UIStoryboard.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

extension UIStoryboard {
    static let LOGIN_VC = "LoginViewController"
    static let REGISTER_VC = "RegisterViewController"
    static let HOME_VC = "HomeViewController"
    static let SEARCH_VC = "SearchViewController"
    static let SETTINGS_VC = "SettingsViewController"
    static let PROFILE_VC = "ProfileViewController"
    static let LIBRARY_VC = "LibraryViewController"

    static var loginStoryboard: UIStoryboard {
        UIStoryboard(name: LOGIN_VC, bundle: nil)
    }

    static var registerStoryboard: UIStoryboard {
        UIStoryboard(name: REGISTER_VC, bundle: nil)
    }

    static var homeStoryboard: UIStoryboard {
        UIStoryboard(name: HOME_VC, bundle: nil)
    }

    static var profileStoryboard: UIStoryboard {
        UIStoryboard(name: PROFILE_VC, bundle: nil)
    }

    static var searchStoryboard: UIStoryboard {
        UIStoryboard(name: SEARCH_VC, bundle: nil)
    }

    static var settingsStoryboard: UIStoryboard {
        UIStoryboard(name: SETTINGS_VC, bundle: nil)
    }

    static var libraryStoryboard: UIStoryboard {
        UIStoryboard(name: LIBRARY_VC, bundle: nil)
    }
}
