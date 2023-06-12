//
//  ProfileViewController.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 17.05.23.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    
    private let profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    
    private var nameLabel: UILabel!
    private var nickLabel: UILabel!
    private var profileDescription: UILabel!
    
    private var profileImageView: UIImageView!
    private var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(forName: ProfileImageService.didChangeNotification,
                         object: nil,
                         queue: .main) { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            }
        updateAvatar()
        
        guard let profile = profileService.profile else { return }
        updateProfileDetails(profile: profile)
        
        setProfileImage()
        setNamelabel()
        setNickName()
        setDescription()
        setLogOutButton()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func updateProfileDetails(profile: Profile) {
        nameLabel.text = profile.name
        nickLabel.text = profile.loginName
        profileDescription.text = profile.bio
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 15)
        profileImageView.kf.setImage(with: url,
                                 placeholder: UIImage(named: "Photo"),
                                 options: [.processor(processor)])
    }
    
    private func setProfileImage() {
        let profileImageView = UIImageView(image: UIImage(named: "avatar"))
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.profileImageView = profileImageView
    }
    
    private func setNamelabel() {
        let nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова 123456789 123456789"
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 23)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        self.nameLabel = nameLabel
    }
    
    private func setNickName() {
        let nickLabel = UILabel()
        nickLabel.text = "@ekaterina_nov"
        nickLabel.textColor = .gray
        nickLabel.font = .boldSystemFont(ofSize: 13)
        nickLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nickLabel)
        nickLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        nickLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        nickLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        self.nickLabel = nickLabel
    }
    
    private func setDescription() {
        let description = UILabel()
        description.text = "Hello, world!"
        description.textColor = .white
        description.font = .boldSystemFont(ofSize: 13)
        description.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(description)
        description.leadingAnchor.constraint(equalTo: nickLabel.leadingAnchor).isActive = true
        description.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: 8).isActive = true
        description.numberOfLines = 0
        description.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        self.profileDescription = description
    }
    
    private func setLogOutButton() {
        let button = UIButton.systemButton(
            with: UIImage(named: "exit button")!,
            target: self,
            action: #selector(Self.didTapButton)
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        button.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        self.logOutButton = button
    }
    
    @objc
    private func didTapButton() {
        
        nameLabel?.removeFromSuperview()
        nameLabel = nil
        
        nickLabel?.removeFromSuperview()
        nickLabel = nil
        
        profileDescription?.removeFromSuperview()
        profileDescription = nil
        
        profileImageView?.image = UIImage(systemName: "person.crop.circle.fill")
        profileImageView?.tintColor = .gray
    }
    
    
}
