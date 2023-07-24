//
//  WebViewViewControllerSpy.swift
//  ImageFeedAVKTests
//
//  Created by Andy Kruch on 23.07.23.
//

@testable import ImageFeedAVK
import UIKit

final class WebViewViewControllerSpy: WebViewViewControllerProtocol {
    var presenter: ImageFeedAVK.WebViewPresenterProtocol?
    
    var loadRequestCalled: Bool = false
    
    func load(request: URLRequest) {
        loadRequestCalled = true
    }
    
    func setProgressValue(_ newValue: Float) {
        
    }
    
    func setProgressHidden(_ isHidden: Bool) {
        
    }
    
    
}
