//
//  OAuthTokenResponseBody.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 12.06.23.
//

import Foundation

import Foundation

struct OAuthTokenResponseBody: Decodable {
    
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        tokenType = try container.decode(String.self, forKey: .tokenType)
        scope = try container.decode(String.self, forKey: .scope)
        createdAt = try container.decode(Int.self, forKey: .createdAt)
    }
}

private enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case scope = "scope"
    case createdAt = "created_at"    
}
