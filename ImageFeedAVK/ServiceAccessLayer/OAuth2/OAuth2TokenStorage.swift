//
//  OAuth2TokenStorage.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 06.06.23.
//

import Foundation

protocol OAuth2TokenStorageProtocol {
    
    var token: String! {get}
    func store(token: String)
}


final class OAuth2TokenStorage {

    private enum Keys: String {
        case token
    }
    
    private let userDefaults: UserDefaults
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(userDefaults: UserDefaults = .standard,
         decoder: JSONDecoder = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.userDefaults = userDefaults
        self.decoder = decoder
        self.encoder = encoder
    }
}

extension OAuth2TokenStorage: OAuth2TokenStorageProtocol {
    
    var token: String! {
        get {
            userDefaults.string(forKey: Keys.token.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.token.rawValue)
        }
        
    }
    func store(token: String) {
        self.token = token
    }
}

