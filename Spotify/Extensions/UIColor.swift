//
//  UIColor.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import UIKit

extension UIColor {
    private static func getColor(red: Double, green: Double, blue: Double) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static let appColor = getColor(red: 30, green: 215, blue: 96)
}
