//
//  UserProfile.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

struct UserProfile: Codable {
    var country: String? = "Germany" // The country of the user
    let display_name: String
    let email: String
    let explicitContent: [String: Int]?
    let external_urls: [String: String]?
    let followers: Followers
    let href: String?
    let id: String
    let images: [Image]?
    let product: String
}

struct Followers: Codable {
    let href: String?
    let total: Int?
}

struct Image: Codable {
    let url: String?
    let height: Double?
    let width: Double?
}
