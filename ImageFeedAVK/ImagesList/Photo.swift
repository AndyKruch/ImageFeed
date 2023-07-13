//
//  Photos.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 13.07.23.
//

import Foundation

import Foundation

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    var isLiked: Bool
}

