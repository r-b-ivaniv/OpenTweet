//
//  UIImageView+Load.swift
//
//
//  Created by Roman Ivaniv on 2024-01-29.
//

import UIKit

public extension UIImageView {
    private static var imageCache = NSCache<NSURL, UIImage>()
    private static var loadingResponses = [NSURL: [(UIImage?) -> Void]]()

    func loadImage(from url: NSURL, placeholder: UIImage? = nil) {
        // Set the placeholder image initially
        self.image = placeholder

        // Check for a cached image.
        if let cachedImage = UIImageView.imageCache.object(forKey: url) {
            self.image = cachedImage
            return
        }

        // In case there are more than one requestor for the image, we append their completion block.
        if UIImageView.loadingResponses[url] != nil {
            UIImageView.loadingResponses[url]?.append { [weak self] image in
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            return
        } else {
            UIImageView.loadingResponses[url] = [ { [weak self] image in
                DispatchQueue.main.async {
                    self?.image = image
                }
            }]
        }

        // Go fetch the image.
        URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            // Check for the error, then data and try to create the image.
            guard let responseData = data, let image = UIImage(data: responseData),
                  let blocks = UIImageView.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    UIImageView.loadingResponses[url]?.forEach { $0(nil) }
                    UIImageView.loadingResponses.removeValue(forKey: url)
                }
                return
            }

            // Cache the image.
            UIImageView.imageCache.setObject(image, forKey: url, cost: responseData.count)

            // Iterate over each requestor for the image and pass it back.
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
            }
        }.resume()
    }
}

