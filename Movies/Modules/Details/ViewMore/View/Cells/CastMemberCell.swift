//
//  CastMemberCell.swift
//  Movies
//
//  Created by Jane Strashok on 08.04.2024.
//

import UIKit
import SnapKit

class CastMemberCell: ViewMoreCell {
    lazy var profilePhoto: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    lazy var nameTitle: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    lazy var dots: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "ellipsis")
        imageView.tintColor = .white.withAlphaComponent(0.3)
        return imageView
    }()
    
    lazy var characterTitle: UILabel = {
        var label = UILabel()
        label.textColor = .unselectedText()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.profilePhoto.image = nil
    }
    
    override func configureView() {
        super.configureView()
        addSubview(profilePhoto)
        addSubview(nameTitle)
        addSubview(dots)
        addSubview(characterTitle)
    }
    
    override func makeContraints() {
        profilePhoto.snp.remakeConstraints { make in
            make.height.width.equalTo(48)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        nameTitle.snp.remakeConstraints { make in
            make.leading.equalTo(profilePhoto.snp.trailing).offset(12)
            make.centerY.equalTo(profilePhoto)
        }
        dots.snp.remakeConstraints { make in
            make.width.equalTo(16)
            make.leading.equalTo(profilePhoto.snp.trailing).offset(163)
            make.centerY.equalTo(profilePhoto)
        }
        characterTitle.snp.remakeConstraints { make in
            make.leading.equalTo(dots.snp.trailing).offset(24)
            make.centerY.equalTo(profilePhoto)
        }
    }
    
    override func configure(castMember: Cast? = nil, photo: UIImage = UIImage(), videoPreview: (String, UIImage) = ("", UIImage())) {
        if let castMember = castMember {
            profilePhoto.image = castMember.profileImage
            nameTitle.text = castMember.name
            characterTitle.text = castMember.character.replacingOccurrences(of: " (voice)", with: "")
        }
    }
}
