//
//  Extension+ImageView.swift
//  BMSAssignment
//
//  Created by Lovina Vijay Hajirawala on 17/05/21.
//

import Foundation
import UIKit

extension UIImageView {
    // alternate to SDWebimage
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }

    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        let imageString = IMAGE_BASE_URL + link
        let imageUrl = URL(string: imageString.replacingOccurrences(of: " ", with: "%20"))
        guard let url = imageUrl else { return }
        downloaded(from: url, contentMode: mode)
    }
}
// end of extension
