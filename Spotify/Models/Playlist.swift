//
//  Playlist.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

struct FeaturedPlaylists: Codable {
    let message: String
    let playlists: Playlists
}

struct Playlists: Codable {
    let items: [Playlist]
    let total: Int
}

struct Playlist: Codable {
    let collaborative: Bool?
    let description: String?
    let external_urls: [String: String]
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let isPublic: Bool?
    let tracks: Tracks
    let type: String?

    enum CodingKeys: String, CodingKey {
        case collaborative
        case description
        case external_urls
        case id
        case images
        case name
        case owner, tracks, type
        case isPublic = "public"
    }
}

struct Tracks: Codable {
    let total: Int
}
