//
//  CustomImageView.swift
//  InstaClone
//
//  Created by Michael Lema on 10/8/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        guard let URL = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            
            if let error = error {
                print("Failed to fetch image: ", error)
            }
            
            if URL.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
}
