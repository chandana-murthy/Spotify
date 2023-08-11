//
//  AudioTrack.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

struct AudioTrack: Codable {
    let album: Album
    let artists: [Artist]
    let available_markets: [String]?
    let external_urls: [String: String]
    let name: String
    let popularity: Int?
    let explicit: Bool?
    let disc_number: Int
    let duration_ms: Int
    let id: String
    let track_number: Int
}
