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
    @IBOutlet var gradientView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    private let gradient = CAGradientLayer()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    //MARK: - LifeCycle
    override func layoutSublayers(of layer: CALayer) {
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.ypBlack.withAlphaComponent(0).cgColor,
                           UIColor.ypBlack.withAlphaComponent(0.2).cgColor]
        gradientView.layer.insertSublayer(gradient, at: 1)
    }
    
    //MARK: - Helpers
    func configCell(for cell: ImagesListCell, from photosName: [String], with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }

        cell.cellImage.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())

        let isLiked = indexPath.row % 2 == 0
        let likeImage = isLiked ? UIImage(named: "noActive") : UIImage(named: "active")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}
