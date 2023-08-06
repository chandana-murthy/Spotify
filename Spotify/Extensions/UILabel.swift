//
//  UILabel.swift
//  Spotify
//
//  Created by Chandana Murthy on 07.08.23.
//

import Foundation
import UIKit

extension UILabel {
    @IBInspectable var localizableText: String? {
        get {
            return text
        } set(value) {
            text = NSLocalizedString(value!, comment: "")
        }
    }

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
