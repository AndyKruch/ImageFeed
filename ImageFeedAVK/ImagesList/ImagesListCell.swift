//
//  ImagesListCell.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 08.05.23.
//

import UIKit


protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
    
}

final class ImagesListCell: UITableViewCell {
    
    
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var gradientView: UIView!
    @IBOutlet private weak var dateLabel: UILabel!
    
    
    static let reuseIdentifier = "ImagesListCell"
    
    private let gradient = CAGradientLayer()
    
    private let imageListService = ImagesListService.shared
    weak var delegate: ImagesListCellDelegate?
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.kf.cancelDownloadTask()
    }
    
    
    //MARK: - Helpers
    @IBAction private func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
    
    func configCell(for cell: ImagesListCell, from photos: [Photo], with indexPath: IndexPath) {
        let imageUrl = photos[indexPath.row].thumbImageURL
        let url = URL(string: imageUrl)
        
        showGradientAnimation(for: cell)
        
        cell.cellImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder_list_photos")) { [weak self] _ in
                self?.cellImage.layer.sublayers?.removeAll()
            }
        
        if photos[indexPath.row].createdAt != nil {
            let photo = photos[indexPath.row]
            cell.dateLabel.text = photo.createdAt?.dateTimeString
        } else {
            cell.dateLabel.text = ""
        }
        
        cell.setIsLiked(photos[indexPath.row].isLiked)
    }
    
    func setIsLiked(_ state: Bool) {
        let likeImage = state ? UIImage(named: "active") : UIImage(named: "noActive")
        likeButton.setImage(likeImage, for: .normal)
    }
    
    private func showGradientAnimation(for cell: ImagesListCell) {
        let gradientAnimation = CAGradientLayer().createLoadingGradient(
            width: UIScreen.main.bounds.width - 32,
            height: UIImage(named: "placeholder_list_photos")?.size.height ?? 252,
            radius: 16
        )
        cell.cellImage.layer.addSublayer(gradientAnimation)
    }
}
