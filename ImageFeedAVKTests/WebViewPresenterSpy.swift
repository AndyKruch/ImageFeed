//
//  WebViewPresenterSpy.swift
//  ImageFeedAVKTests
//
//  Created by Andy Kruch on 23.07.23.
//

@testable import ImageFeedAVK
import Foundation

final class WebViewPresenterSpy: WebViewPresenterProtocol {
    
    var viewDidLoadCalled: Bool = false
    var view: WebViewViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didUpdateProgressValue(_ newValue: Double) {
    
    }
    
    func fetchCode(from url: URL) -> String? {
        return nil
    }
}
