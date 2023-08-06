//
//  UIViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

extension UIViewController {
    func showErrorAlertWithDismiss(title: String = Strings.error, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: Strings.ok, style: .cancel)
        alert.addAction(dismissAction)
        self.present(alert, animated: true)
    }

    func showAlertWithActions(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
}


// MARK: - Controllers
extension UIViewController {
    static func homeViewController() -> UINavigationController {
        let storyboard = UIStoryboard.homeStoryboard
        guard let vc = storyboard.instantiateInitialViewController() as? HomeViewController else {
            print("Storyboard \(#function) not configured. Check for initialViewcontroller")
            fatalError("This should not be null")
        }
        let navController = UINavigationController(rootViewController: vc)
        return navController
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

    static func searchViewController() -> UINavigationController {
        let storyboard = UIStoryboard.searchStoryboard
        guard let vc = storyboard.instantiateInitialViewController() as? SearchViewController else {
            fatalError("Something went wrong here: \(#function)")
        }
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }

    static func libraryViewController() -> UINavigationController {
        let storyboard = UIStoryboard.libraryStoryboard
        guard let vc = storyboard.instantiateInitialViewController() as? LibraryViewController else {
            fatalError("Something went wrong here: \(#function)")
        }
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }

    static func authViewController(completion: ((Bool, Error?) -> Void)?) -> AuthViewController {
        let storyboard = UIStoryboard.authStoryboard
        guard let vc = storyboard.instantiateInitialViewController() as? AuthViewController else {
            fatalError("Something went wrong here: \(#function)")
        }
        vc.completionHandler = completion
        return vc
    }
}
