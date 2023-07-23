//
//  UILabel.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 13.07.23.
//

import UIKit

extension UILabel {
    func config(for label: UILabel, text: String, fontSize: CGFloat, textColor: UIColor) {
        label.text = text
        label.font = UIFont(name: "YS Display", size: fontSize)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}
