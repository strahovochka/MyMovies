//
//  UIStackView+Extensions.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        self.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func removeAllArrangedSubviews<T>(ofType type: T) {
        self.subviews.forEach { view in
            if view is T {
                view.removeFromSuperview()
            }
        }
    }
    
    func makeStarRating(of voteAverage: Double) {
        let rating = round(voteAverage / 2 * 10) / 10.0
        for i in 0..<5 {
            let diff = rating - Double(i)
            switch i {
            case _ where diff >= 1:
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(systemName: "star.fill")
                imageView.tintColor = UIColor(hex: "#FFC045")
                addArrangedSubview(imageView)
            case _ where (diff > 0 && diff < 1):
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(systemName: "star.leadinghalf.filled")
                imageView.tintColor = UIColor(hex: "#FFC045")
                addArrangedSubview(imageView)
            default:
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(systemName: "star")
                imageView.tintColor = UIColor(hex: "#FFC045")
                addArrangedSubview(imageView)
            }
        }
    }
}
