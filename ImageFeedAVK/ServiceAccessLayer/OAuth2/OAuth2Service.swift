//
//  OAuth2Service.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 06.06.23.
//

import Foundation


final class OAuth2Service {
    
     private let urlSession = URLSession.shared
     private var task: URLSessionTask?
     private var lastCode: String?
     static let shared = OAuth2Service()

     private enum NetworkError: Error {
         case codeError
    }
    
    func fetchAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        assert(Thread.isMainThread)
        if lastCode == code { return }
        task?.cancel()
        lastCode = code
        
        let request = makeRequest(code: code)
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            guard let self = self else { return }
            
            self.task = nil
            switch result {
            case .success(let responseBody):
                let authToken = responseBody.accessToken
                completion(.success(authToken))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        self.task = task
        task.resume()
    }
        
        private func makeRequest(code: String) -> URLRequest {
            var urlComponents = URLComponents(string: unsplashAuthorizeURLString)
            urlComponents?.queryItems = [
                URLQueryItem(name: "client_id", value: AccessKey),
                URLQueryItem(name: "client_secret", value: SecretKey),
                URLQueryItem(name: "redirect_uri", value: RedirectURI),
                URLQueryItem(name: "code", value: code),
                URLQueryItem(name: "grant_type", value: "authorization_code")
            ]
            guard let url = urlComponents?.url else { fatalError("Failed to create URL") }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            return request
        }
    }

// MARK: - Network Connection
enum NetworkError: Error {
 case httpStatusCode(Int)
 case urlRequestError(Error)
 case urlSessionError
 }

 extension URLSession {
     func objectTask<Model: Decodable>(
         for request: URLRequest,
         completion: @escaping (Result<Model, Error>) -> Void
     ) -> URLSessionTask {
         let fulfillCompletion: (Result<Model, Error>) -> Void = { result in
             DispatchQueue.main.async {
                 completion(result)
             }
         }
         let task = dataTask(with: request, completionHandler: { data, response, error in
             if let data = data,
                let response = response,
                let statusCode = (response as? HTTPURLResponse)?.statusCode {
                 if 200 ..< 300 ~= statusCode {
                     do {
                         let decoder = JSONDecoder()
                         let result = try decoder.decode(Model.self, from: data)
                         fulfillCompletion(.success(result))
                     } catch {
                         fulfillCompletion(.failure(NetworkError.urlRequestError(error)))
                     }
                 } else {
                     fulfillCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                 }
             } else if let error = error {
                 fulfillCompletion(.failure(NetworkError.urlRequestError(error)))
             } else {
                 fulfillCompletion(.failure(NetworkError.urlSessionError))
             }
         })
         task.resume()
         return task
     }
 }
