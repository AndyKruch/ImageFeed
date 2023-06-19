//
//  OAuthTokenResponseBody.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 12.06.23.
//

import Foundation

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken, tokenType, scope: String
    let createdAt: Date
   
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
}
