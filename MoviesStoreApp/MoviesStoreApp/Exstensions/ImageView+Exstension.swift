//
//  ImageView+Exstension.swift
//  MoviesStoreApp
//
//  Created by Александр Андреевич Щепелин on 25.10.2022.
//

import UIKit

/// Расширение для загрузки картинки
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url) {
                DispatchQueue.main.async { [weak self] in
                    if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                    }
                }
            }
        }
    }
}
