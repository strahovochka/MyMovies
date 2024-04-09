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
    
    lazy var playButton: UIButton = {
        var button = UIButton()
        button.setImage(.playButtonIcon(), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        return button
    }()
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    override func configureView() {
        addSubview(imageView)
        contentView.addSubview(playButton)
    }
    
    func configureView(asPhoto: Bool) {
        playButton.isHidden = asPhoto
        layoutSubviews()
    }
    
    override func makeConstraints() {
        imageView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        playButton.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(20)
        }
    }
}
