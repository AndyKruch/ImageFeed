//
//  TabBarController.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 13.06.23.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let imageListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
        imageListViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("", comment: ""),
                                                          image: UIImage(named: "tab_editorial_active"),
                                                          selectedImage: nil)
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("", comment: ""),
                                                        image: UIImage(named: "tab_profile_active"),
                                                        selectedImage: nil)
        
        self.viewControllers = [imageListViewController, profileViewController]
    }
}
