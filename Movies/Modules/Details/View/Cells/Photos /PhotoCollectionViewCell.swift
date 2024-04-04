//
//  PhotoCollectionViewCell.swift
//  Movies
//
//  Created by Jane Strashok on 04.04.2024.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: BaseCollectionViewCell {
    
    lazy var imageView: UIImageView = {
        var view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    override func configureView() {
        addSubview(imageView)
    }
    
    override func makeConstraints() {
        imageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
