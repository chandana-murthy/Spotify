//
//  UIFont.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

extension UIFont {
    static func appFont(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Avenir Next", size: size) else {
            fatalError("Check font name")
        }
        return font
    }
}
