//
//  APICaller.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation
import Alamofire

final class APICaller {
    static let shared = APICaller()

    private init() { }

    private func getHeader(completion: @escaping ((HTTPHeaders) -> Void)) {
        AuthManager.shared.withValidToken { token in
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            completion(headers)
        }
    }

    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, AFError>) -> Void) {
        getHeader { headers in
            AF.request(Constants.baseAPIUrl + "/me",
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseDecodable(of: UserProfile.self) { response in
                completion(response.result)
            }
        }
    }

    func getNewReleases(completion: @escaping (Result<NewReleases, AFError>) -> Void) {
        let url = Constants.baseAPIUrl + "/browse/new-releases?limit=50"
        getHeader { headers in
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseDecodable(of: NewReleases.self) { response in
                completion(response.result)
            }
        }
    }

    func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylists, AFError>) -> Void) {
        let url = Constants.baseAPIUrl + "/browse/featured-playlists"
        getHeader { headers in
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseDecodable(of: FeaturedPlaylists.self) { response in
                completion(response.result)
            }
        }
    }
    
    func getRecommendations(genres: Set<String>, completion: @escaping (Result<Recommendations, AFError>) -> Void) {
        let seeds = genres.joined(separator: ",")
        let url = Constants.baseAPIUrl + "/recommendations?seed_genres=\(seeds)"
        getHeader { headers in
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseDecodable(of: Recommendations.self) { response in
                completion(response.result)
            }
        }
    }

    func getRecommendedGenres(completion: @escaping (Result<Genres, AFError>) -> Void) {
        let url = Constants.baseAPIUrl + "/recommendations/available-genre-seeds"
        getHeader { headers in
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .responseDecodable(of: Genres.self) { response in
                completion(response.result)
            }
        }
    }
}
