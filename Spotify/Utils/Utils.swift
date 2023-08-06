//
//  Utils.swift
//  Spotify
//
//  Created by Chandana Murthy on 07.08.23.
//

import UIKit

func profilePic(with name: String, lastName: String?, rounden: Bool = true) -> UIImage {
    if name.isEmpty {
        return UIImage.person ?? UIImage.add
    }
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    label.backgroundColor = .white
    label.font = UIFont.appFont(size: 30)
    label.textColor = .appColor
    label.textAlignment = .center
    label.layer.borderWidth = 0.5
    var displayString = String(name.prefix(1))
    if let lastName = lastName, !lastName.isEmpty {
        displayString += String(lastName.prefix(1))
    }
    displayString = displayString.uppercased()
    label.text = displayString
    if rounden {
        label.rounden()
    }
    return label.asImage()
}

