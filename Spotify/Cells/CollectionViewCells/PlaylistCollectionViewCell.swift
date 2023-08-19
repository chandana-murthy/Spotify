//
//  PlayListCollectionViewCell.swift
//  Spotify
//
//  Created by Chandana Murthy on 19.08.23.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!

    static let cellIdentifier: String = "playlistCollectionViewCell"

    func setCellTitle(_ title: String) {
        self.title.text = title
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib {
        return UINib(nibName: "PlayListCollectionViewCell", bundle: nil)
    }

}
