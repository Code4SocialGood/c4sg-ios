//
//  UIImageView.swift
//  Code4SocialGood
//
//  Created by Derek Carter on 1/23/18.
//  Copyright © 2018 Code 4 Social Good. All rights reserved.
//

import UIKit

public var AsyncImagesCacheArray = NSCache<NSString, UIImage>() // Used only for image caching

extension UIImageView {
    
    public func loadAsyncImageFrom(url: String, withPlaceholder placeholder: UIImage?) {
        let imageURL = url as NSString
        
        // Get cached image if available
        if let cachedImage = AsyncImagesCacheArray.object(forKey: imageURL) {
            self.image = cachedImage
            return
        }
        
        // Start off with the placeholder image
        self.image = placeholder
        
        // Protect against malformed URLs
        guard let requestURL = URL(string: url) else {
            self.image = placeholder
            return
        }
        
        // Download and set the image
        let request: URLRequest = URLRequest.init(url: requestURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30.0)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { [weak self] in
                if error == nil {
                    if let imageData = data {
                        if let currentImage = UIImage(data: imageData) {
                            AsyncImagesCacheArray.setObject(currentImage, forKey: imageURL)
                            self?.image = currentImage
                        }
                        else {
                            self?.image = placeholder
                        }
                    }
                    else {
                        self?.image = placeholder
                    }
                }
                else {
                    self?.image = placeholder
                }
            }
            }.resume()
    }
}
