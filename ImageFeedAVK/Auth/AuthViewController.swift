//
//  AuthViewController.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 06.06.23.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate()
}

class AuthViewController: UIViewController {
    //MARK: - Properties
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    private var oAuth2TokenStorage = OAuth2TokenStorage()
    private let oAuth2Service = OAuth2Service()

    weak var delegate: AuthViewControllerDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
            let authHelper = AuthHelper()
            let webViewPresenter = WebViewPresenter(authHelper: authHelper)
            webViewViewController.presenter = webViewPresenter
            webViewPresenter.view = webViewViewController
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    private func saveAccessToken(_ accessToken: String) {
        oAuth2TokenStorage.token = accessToken
    }
}

//MARK: - WebViewViewControllerDelegate
extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        vc.dismiss(animated: true)
        UIBlockingProgressHUD.show()
        oAuth2Service.fetchAuthToken(code) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                UIBlockingProgressHUD.dismiss()
                switch result {
                case .success(let accessToken):
                    self.saveAccessToken(accessToken)
                    self.delegate?.didAuthenticate()
                case .failure:
                    UIBlockingProgressHUD.dismiss()
                    self.showSingleAlert(
                        title: "Что-то пошло не так(",
                        message: "Не удалось войти в систему",
                        nil
                    )
                }
            }
        }
    }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}
