//
//  AuthManager.swift
//  Spotify
//  This is specifically for the account alertgrafana1234@gmail.com
//  To get the pwd, please contact developer.
//  Or rewrite the client ID and secret for your spotify account
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()

    struct Constants {
        static let clientID = "90d1438151c8486f8623e395b94834e0"
        static let clientSecret = "8ce1730b4c0442469fd4f56a3836f845"
        static let tokenAPIUrl = "https://accounts.spotify.com/api/token"
        static let redirectUrl = "http://localhost:8888/callback"
        static let scopes = "user-read-private%20playlist-modify-private%20playlist-modify-public%20playlist-read-private%20user-follow-read%20user-library-modify%20user-library-read%20user-top-read%20user-read-email"
    }

    private init() { }

    public var signInUrl: URL? {
        let baseUrl = "https://accounts.spotify.com/authorize"
        let string = "\(baseUrl)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectUrl)&show_dialog=true"
        return URL(string: string)
    }

    var isSignedIn: Bool {
        return accessToken != nil
    }
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    private var shouldRefreshToken: Bool {
        guard let expireDate = tokenExpirationDate else {
            return true
        }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expireDate
    }

    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool, Error?) -> Void)) {
        guard let url = URL(string: Constants.tokenAPIUrl) else {
            completion(false, SError.invalidAPIToken)
            return
        }
        var component = URLComponents()
        component.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectUrl)]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = component.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false, SError.unknownError)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data, error == nil else {
                completion(false, error)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completion(true, nil)
            } catch let error {
                print(error.localizedDescription)
                completion(false, error)
            }
        }
        task.resume()
    }

    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let token = result.refresh_token {
            UserDefaults.standard.setValue(token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }

    func refreshTheToken(completion: @escaping ((Bool) -> Void)) {
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        guard let refreshToken = self.refreshToken else {
            completion(false)
            return
        }

        // Refresh the token
        guard let url = URL(string: Constants.tokenAPIUrl) else {
            completion(false)
            return
        }
        var component = URLComponents()
        component.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = component.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data, error == nil else {
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completion(true)
            } catch let error {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
}
