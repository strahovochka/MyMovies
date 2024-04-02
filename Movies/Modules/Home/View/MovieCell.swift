//
//  MovieCell.swift
//  Movies
//
//  Created by Jane Strashok on 26.03.2024.
//

import UIKit
import SnapKit

class MovieCell: BaseCollectionViewCell {
    lazy var imageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var starStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 2
        return stack
    }()
    
    lazy var title: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var genreAndTime: UILabel = {
        var label = UILabel()
        label.textColor = .white.withAlphaComponent(0.5)
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.starStack.removeAllArrangedSubviews()
    }
    
    override func configureView() {
        addSubview(imageView)
        addSubview(title)
        addSubview(genreAndTime)
    }
    
    override func makeConstraints() {
        imageView.snp.remakeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height * 0.31)
        }
        title.snp.remakeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(37)
            make.leading.trailing.equalToSuperview()
        }
        genreAndTime.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(4)
        }
    }
    
    func configureCell(model: Movies) {
        title.text = model.title
        
        starStack.makeStarRating(of: model.voteAverage)
        addSubview(starStack)
        starStack.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.height.equalTo(screenSize.height * 0.02)
        }
    }
}
