//
//  ProfilePresenterSpy.swift
//  ImageFeedAVKTests
//
//  Created by Andy Kruch on 23.07.23.
//

@testable import ImageFeedAVK
import UIKit

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    
    var viewDidLoadCalled: Bool = false
    var view: ProfileViewControllerProtocol?
    var didLogoutCalled: Bool = false
    var clean: Bool = false
    var observe: Bool = false
    var alert: Bool = false

    var profileService: ImageFeedAVK.ProfileService
    
    init (profileService: ProfileService ) {
        self.profileService = profileService
    }
    
    func updateProfileDetails(profile: Profile?) {
        view?.configureViews()
        view?.configureConstraints()
    }
    
    func observeAvatarChanges() {
        observe = true
    }
    
    func logout() {
         didLogoutCalled = true
    }
    
    func cleanServicesData() {
        clean = true
    }
    
    func getUrlForProfileImage() -> URL? {
        return URL(string: "\(DefaultBaseURL!)")
    }
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func makeAlert() -> UIAlertController {
        UIAlertController()
    }
    
}
