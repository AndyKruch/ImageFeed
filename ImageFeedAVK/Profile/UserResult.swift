//
//  UserResult.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 13.07.23.
//

import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImage?
    
    private enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}
