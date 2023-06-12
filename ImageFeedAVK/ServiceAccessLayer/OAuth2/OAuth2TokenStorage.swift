//
//  OAuth2TokenStorage.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 06.06.23.
//

import Foundation

final class OAuth2TokenStorage {
    
    private enum Keys: String {
        case bearerToken
     }

     private let userDefaults = UserDefaults.standard
     static let shared = OAuth2TokenStorage()

     var token: String? {
         get {
            userDefaults.string(forKey: Keys.bearerToken.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.bearerToken.rawValue)
        }
    }
}
