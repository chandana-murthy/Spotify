//
//  UIView.swift
//  Spotify
//
//  Created by Chandana Murthy on 07.08.23.
//

import UIKit

extension UIView {
    func rounden(border: Bool = false, borderColor: UIColor = .gray) {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
        if border {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1
        }
    }

    func cornerView(radius: CGFloat = 8) {
        self.layer.cornerRadius = radius
    }
}
