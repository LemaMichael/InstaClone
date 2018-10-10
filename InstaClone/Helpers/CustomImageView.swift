//
//  CustomImageView.swift
//  InstaClone
//
//  Created by Michael Lema on 10/8/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        
        // Check the cache for the image
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let URL = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            
            if let error = error {
                print("Failed to fetch image: ", error)
                return
            }
            
            if URL.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            imageCache[URL.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
}
