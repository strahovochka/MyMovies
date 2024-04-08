//
//  CastMemberView.swift
//  Movies
//
//  Created by Jane Strashok on 04.04.2024.
//

import UIKit
import SnapKit

class CastMemberView: UIView {
    
    lazy var image: UIImageView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        makeContraints()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView() {
        backgroundColor = .clear
        addSubview(image)
        addSubview(nameTitle)
        addSubview(dots)
        addSubview(characterTitle)
    }
    
    func makeContraints() {
        image.snp.remakeConstraints { make in
            make.height.width.equalTo(48)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        nameTitle.snp.remakeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(12)
            make.centerY.equalTo(image)
        }
        dots.snp.remakeConstraints { make in
            make.width.equalTo(16)
            make.leading.equalTo(image.snp.trailing).offset(163)
            make.centerY.equalTo(image)
        }
        characterTitle.snp.remakeConstraints { make in
            make.leading.equalTo(dots.snp.trailing).offset(24)
            make.centerY.equalTo(image)
        }
    }
    
    func configure(with castMember: Cast) {
        image.image = castMember.profileImage
        nameTitle.text = castMember.name
        
        characterTitle.text = castMember.character.replacingOccurrences(of: " (voice)", with: "").uppercased()
    }

}
