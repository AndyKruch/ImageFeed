//
//  SingleImageViewController.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 21.05.23.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return } // 1
            imageView.image = image // 2
        }
    }
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            imageView.image = image
        }
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
