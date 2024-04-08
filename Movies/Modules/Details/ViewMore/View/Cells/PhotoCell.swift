//
//  PhotoCell.swift
//  Movies
//
//  Created by Jane Strashok on 08.04.2024.
//

import UIKit
import SnapKit

class PhotoCell: ViewMoreCell {
    lazy var photoImageView: UIImageView = {
        var view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 4
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
    
    override func configureView() {
        super.configureView()
        addSubview(photoImageView)
    }
    
    override func makeContraints() {
        photoImageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configure(castMember: Cast? = nil, photo: UIImage = UIImage(), videoPreview: (String, UIImage) = ("", UIImage())) {
        self.photoImageView.image = photo
    }
}
