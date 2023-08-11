//
//  Album.swift
//  Spotify
//
//  Created by Chandana Murthy on 11.08.23.
//

import Foundation

struct Album: Codable {
    let album_type: String
    let total_tracks: Int
    let available_markets: [String]?
    let id: String
    let images: [Image]?
    let name: String
    let release_date: String
    let type: String
    let uri: String?
    let genres: [String]?
    let label: String?
    let popularity: Int
    let artists: [Artist]
    let album_group: String?
}

struct Albums: Codable {
    let total: Int
    let items: [Album]
}
