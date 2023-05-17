//
//  ProfileViewController.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 17.05.23.
//

import UIKit

final class ProfileViewController: UIViewController {
  
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    @IBOutlet private var logoutButton: UIButton!
    
    
    @IBAction func didTapLogoutButton() {
    }
    
}
