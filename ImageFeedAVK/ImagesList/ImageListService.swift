//
//  ImageListService.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 28.06.23.
//

import Foundation
import UIKit

struct PhotoResult: Decodable {
    let id: String
    let createdAt: String?
    let welcomeDescription: String?
    let isLiked: Bool?
    let urls: ImageUrlsResult?
    let width: Int?
    let height: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case welcomeDescription = "description"
        case isLiked = "liked_by_user"
        case urls = "urls"
        case width = "width"
        case height = "height"
    }
}

struct ImageUrlsResult: Decodable {
     let thumbImageURL: String?
     let largeImageURL: String?

     enum CodingKeys: String, CodingKey {
         case thumbImageURL = "thumb"
         case largeImageURL = "full"
     }
 }

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case welcomeDescription = "description"
        case isLiked = "liked_by_user"
        case urls = "urls"
        case width = "width"
        case height = "height"
    }
}


final class ImagesListService {
    static let DidChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    static let shared = ImagesListService()
    private let oAuth2TokenStorage = OAuth2TokenStorage.shared
    private (set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private let perPage = "10"
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
}


extension ImagesListService {
    
    func fetchPhotosNextPage() {
        
        assert(Thread.isMainThread)
        task?.cancel()
        
        guard let token = oAuth2TokenStorage.token else { return }
        let page = lastLoadedPage == nil ? 1 : lastLoadedPage! + 1
        let request = makeRequest(token: token, page: String(page), perPage: perPage)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let photoResults):
                for photoResult in photoResults {
                    self.photos.append(self.convert(photoResult))
                }
                self.lastLoadedPage = page
                NotificationCenter.default
                    .post(
                        name: ImagesListService.DidChangeNotification,
                        object: self,
                        userInfo: ["Images" : self.photos])
            case .failure(_):
                break
            }
        }
        self.task = task
        task.resume()
        
    }
    
    private func convert(_ photoResult: PhotoResult) -> Photo {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:photoResult.createdAt ?? "")
        
        return Photo.init(id: photoResult.id,
                          size: CGSize(width: photoResult.width ?? 0, height: photoResult.height ?? 0),
                          createdAt: date,
                          welcomeDescription: photoResult.welcomeDescription,
                          thumbImageURL: (photoResult.urls?.thumbImageURL)!,
                          largeImageURL: (photoResult.urls?.largeImageURL)!,
                          isLiked: photoResult.isLiked ?? false)
    }
    
    private func makeRequest(token: String, page: String, perPage: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.path = "/photos?page=\(page)&&per_page=\(perPage)"
        
        guard let url = urlComponents.url(relativeTo: defaultBaseURL) else { fatalError("Failed to create URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}


