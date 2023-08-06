//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = .black
        self.navigationItem.hidesBackButton = true
        setupTabs()
    }

    private func setupTabs() {
        // Tab one
        let homeTab = UIViewController.homeViewController()
        homeTab.tabBarItem = UITabBarItem(title: Strings.home, image: UIImage.home, tag: 0)

        // Tab two
        let searchTab = UIViewController.searchViewController()
        searchTab.tabBarItem = UITabBarItem(title: Strings.search, image: UIImage.search, tag: 1)

        // Tab three
        let libraryTab = UIViewController.libraryViewController()
        libraryTab.tabBarItem = UITabBarItem(title: Strings.yourLibrary, image: UIImage.library, tag: 2)

        setTabBarAppearance()
        self.viewControllers = [homeTab, searchTab, libraryTab]
    }

    private func setTabBarAppearance() {
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.appFont(size: 13)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("selected tab: \(viewController)")
    }
}
