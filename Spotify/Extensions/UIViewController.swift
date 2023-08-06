//
//  UIViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

extension UIViewController {

}


// MARK: - Controllers
extension UIViewController {
    static func homeViewController() -> HomeViewController {
        let storyboard = UIStoryboard.homeStoryboard
        guard let viewController = storyboard.instantiateInitialViewController() as? HomeViewController else {
            print("Storyboard \(#function) not configured. Check for initialViewcontroller")
            fatalError("This should not be null")
        }
        return viewController
    }

    static func profileViewController() -> ProfileViewController {
        let storyboard = UIStoryboard.profileStoryboard
        guard let vc = storyboard.instantiateInitialViewController() as? ProfileViewController else {
            fatalError("Something went wrong here: \(#function)")
        }
        return vc
    }

    static func settingsController() -> SettingsViewController {
        let storyboard = UIStoryboard.settingsStoryboard
        guard let vc = storyboard.instantiateInitialViewController() as? SettingsViewController else {
            fatalError("Something went wrong here: \(#function)")
        }
        return vc
    }

    static func searchViewController() -> SearchViewController {
        let storyboard = UIStoryboard.searchStoryboard
        guard let vc = storyboard.instantiateInitialViewController() as? SearchViewController else {
            fatalError("Something went wrong here: \(#function)")
        }
        return vc
    }

    static func libraryViewController() -> LibraryViewController {
        let storyboard = UIStoryboard.libraryStoryboard
        guard let vc = storyboard.instantiateInitialViewController() as? LibraryViewController else {
            fatalError("Something went wrong here: \(#function)")
        }
        return vc
    }
}
