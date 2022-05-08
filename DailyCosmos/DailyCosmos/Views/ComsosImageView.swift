//
//  ComsosImageView.swift
//  DailyCosmos
//
//  Created by Manjeet Singh on 08/05/22.
//

import Foundation
import UIKit

class CosmosImageView: UIImageView {
    var imageUrl: String?
    
    func load(from imageUrl: String,
              contentMode mode: ContentMode = .scaleAspectFill,
              withPlaceHolder placeHolderImage: UIImage? = nil) {
        self.imageUrl = imageUrl
        self.image = placeHolderImage
        guard let url = URL(string: imageUrl) else {
            return
        }
        downloaded(from: url, contentMode: mode)
    }
    
    private func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {[unowned self] in
                if let imageUrlUnwrapped = self.imageUrl, imageUrlUnwrapped == url.absoluteString {
                    self.addAnimatedImage(image: image.withRenderingMode(.alwaysOriginal))
                }
            }
        }.resume()
    }
    
    func addAnimatedImage(image: UIImage) {
        UIView.transition(with: self,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.image = image },
                          completion: nil)
    }
}
