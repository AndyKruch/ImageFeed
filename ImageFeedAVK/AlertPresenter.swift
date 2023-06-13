//
//  AlertPresenter.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 13.06.23.
//

import Foundation
import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: ((UIAlertAction) -> Void)?
}

struct AlertPresenter {
    weak var present: UIViewController?
    func showResult(alertModel: AlertModel) {
        let alert = UIAlertController(title: alertModel.title,
                                      message: alertModel.message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: alertModel.buttonText,
                                   style: .default,
                                   handler: alertModel.completion)
        alert.addAction(action)
        present?.present(alert, animated: true, completion: nil)
    }
}
