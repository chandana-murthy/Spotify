//
//  AuthManager.swift
//  Spotify
//
//  rewrite the client ID and secret for your spotify account
//
//  Created by Chandana Murthy on 06.08.23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    private var isRefreshingToken = false

    struct AuthConstants {
        static let clientID = ""
        static let clientSecret = ""
        static let tokenAPIUrl = "https://accounts.spotify.com/api/token"
        static let redirectUrl = "http://localhost:8888/callback"
        static let scopes = "user-read-private%20playlist-modify-private%20playlist-modify-public%20playlist-read-private%20user-follow-read%20user-library-modify%20user-library-read%20user-top-read%20user-read-email"
    }

    private init() { }

    public var signInUrl: URL? {
        let baseUrl = "https://accounts.spotify.com/authorize"
        let string = "\(baseUrl)?response_type=code&client_id=\(AuthConstants.clientID)&scope=\(AuthConstants.scopes)&redirect_uri=\(AuthConstants.redirectUrl)&show_dialog=true"
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
        guard let url = URL(string: AuthConstants.tokenAPIUrl) else {
            completion(false, SError.invalidAPIToken)
            return
        }
        var component = URLComponents()
        component.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: AuthConstants.redirectUrl)]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = component.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let basicToken = AuthConstants.clientID + ":" + AuthConstants.clientSecret
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

    private var onRefreshBlocks = [((String) -> Void)]()

    /// supplies valid token to be used with API calls
    func withValidToken(completion: @escaping ((String) -> Void)) {
        guard !isRefreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            //refresh
            refreshTheToken { [weak self] success in
                if success, let token = self?.accessToken {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }

    func refreshTheToken(completion: ((Bool) -> Void)?) {
        guard !isRefreshingToken else {
            return
        }
        guard let refreshToken = self.refreshToken, let url = URL(string: AuthConstants.tokenAPIUrl) else {
            completion?(false)
            return
        }

        // Refresh the token
        isRefreshingToken = true
        var component = URLComponents()
        component.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = component.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let basicToken = AuthConstants.clientID + ":" + AuthConstants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion?(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            self?.isRefreshingToken = false
            guard let data, error == nil else {
                completion?(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.onRefreshBlocks.forEach { $0(result.access_token) }
                self?.onRefreshBlocks.removeAll()
                self?.cacheToken(result: result)
                completion?(true)
            } catch let error {
                print(error.localizedDescription)
                completion?(false)
            }
        }
        task.resume()
    }
}
