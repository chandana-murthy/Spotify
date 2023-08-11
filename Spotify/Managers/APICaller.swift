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
        let url = Constants.baseAPIUrl + "/browse/new-releases"
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
}
