//
//  Owner.swift
//  Spotify
//
//  Created by Chandana Murthy on 11.08.23.
//

import Foundation

struct Owner: Codable {
    let followers: Followers?
    let id: String
    let type: String?
    let uri: String?
    let display_name: String
}
