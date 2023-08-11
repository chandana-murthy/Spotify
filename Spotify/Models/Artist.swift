//
//  Artist.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let uri: String?
}
