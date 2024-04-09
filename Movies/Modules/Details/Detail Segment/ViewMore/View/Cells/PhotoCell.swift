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
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
    
    override func configureView() {
        super.configureView()
        contentView.addSubview(photoImageView)
    }
    
    override func makeContraints() {
        photoImageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configure(castMember: Cast? = nil, photo: UIImage = UIImage(), videoKey: String = "") {
        self.photoImageView.image = photo
    }
    
    func remakeConstraints() {
        photoImageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
    }
}
