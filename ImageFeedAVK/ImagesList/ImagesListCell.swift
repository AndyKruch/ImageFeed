//
//  ImagesListCell.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 08.05.23.
//

import UIKit


final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
}
