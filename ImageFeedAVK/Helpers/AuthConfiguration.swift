//
//  Constants.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 06.06.23.
//

import Foundation

let AccessKey = "OMcab6iCOAxJpYFuvwqvADr5WwTtggOnzZFQzLmk9-w"
let SecretKey = "SSbQ2BC1M7KqtNV2BulYbD5KMO2E3SPfyartIFoe3Ik"
let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let AccessScope = "public+read_user+write_likes"

let DefaultBaseURL = URL(string: "https://api.unsplash.com")
let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
let unsplashAuthorizeTokenURLString = "https://unsplash.com/oauth/token"
let unsplashGetProfile = "https://api.unsplash.com/me"
let unsplashGetProfileImage = "https://api.unsplash.com/users/"
let unsplashGetListPhotos = "https://api.unsplash.com/photos"


struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    
    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, authURLString: String, defaultBaseURL: URL) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
    
    static var standard: AuthConfiguration {
            return AuthConfiguration(accessKey: AccessKey,
                                     secretKey: SecretKey,
                                     redirectURI: RedirectURI,
                                     accessScope: AccessScope,
                                     authURLString: UnsplashAuthorizeURLString,
                                     defaultBaseURL: DefaultBaseURL!)
        }
}
