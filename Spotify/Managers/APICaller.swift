//
//  APICaller.swift
//  Spotify
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()

    private init() { }

    enum HTTPMethod: String {
        case GET
        case POST
    }


    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping ((URLRequest) -> Void)) {
        AuthManager.shared.withValidToken { token in
            guard let url = url else {
                return
            }
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }

    func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIUrl + "/me"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data, error == nil else {
                    completion(.failure(SError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
