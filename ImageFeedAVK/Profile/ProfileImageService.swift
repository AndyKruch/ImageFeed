//
//  ProfileImageService.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 11.06.23.
//


import Foundation
import UIKit

final class ProfileImageService {
    static let DidChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    static let shared = ProfileImageService()
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private let storageToken = OAuth2TokenStorage()
    private (set) var avatarURL: String?

    func clean() {
        avatarURL = nil
        task?.cancel()
        task = nil
    }
    
     func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
         assert(Thread.isMainThread)

         let request = makeRequest(token: storageToken.token!, username: username)
         let session = URLSession.shared
         let task = session.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
             guard let self = self else { return }
             switch result {
             case .success(let decodedObject):
                 let avatarURL = ProfileImage(decodedData: decodedObject)
                 self.avatarURL = avatarURL.profileImage["large"]
                 completion(.success(self.avatarURL!))
                 NotificationCenter.default.post(
                     name: ProfileImageService.DidChangeNotification,
                     object: self,
                     userInfo: ["URL": self.avatarURL!])
             case .failure(let error):
                 completion(.failure(error))
             }
         }
         self.task = task
         task.resume()
     }

     private func makeRequest(token: String, username: String) -> URLRequest {
         guard let url = URL(string: "\(APIConstants.defaultBaseURL)" + "/users/" + username) else { fatalError("Failed to create URL") }
         var request = URLRequest(url: url)
         request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
         return request
     }
 }

struct UserResult: Codable {
    let profileImage: [String:String]

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let profileImage: [String:String]

    init(decodedData: UserResult) {
        self.profileImage = decodedData.profileImage
    }
}

