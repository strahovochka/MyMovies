//
//  PosterTableViewCell.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit
import SnapKit

class PosterCell: DetailsCell {

    lazy var posterImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var title: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var genres: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .unselectedText()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var ratingStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    lazy var rating: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    lazy var starStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 4
        return stack
    }()
    
    lazy var segmentControl: CustomSegmentControl = {
        var view = CustomSegmentControl(items: DetailsViewType.allCases.map({$0.rawValue}))
        let unselectedTextStyle: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.unselectedText(),
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let selectedTextStyle: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.setTitleTextAttributes(unselectedTextStyle, for: .normal)
        view.setTitleTextAttributes(selectedTextStyle, for: .selected)
        view.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
        starStack.removeAllArrangedSubviews()
    }
    
    override func configureView() {
        super.configureView()
        addSubview(posterImage)
        addSubview(title)
        addSubview(genres)
        ratingStack.addArrangedSubview(rating)
        ratingStack.addArrangedSubview(starStack)
        addSubview(ratingStack)
        contentView.addSubview(segmentControl)
        
    }
    
    override func makeContraints() {
        posterImage.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.top.equalToSuperview().inset(24)
            make.width.equalTo(posterImage.snp.height).multipliedBy(0.67)
        }
        title.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(41)
            make.top.equalTo(posterImage.snp.bottom).offset(32)
        }
        genres.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(title.snp.bottom).offset(16)
        }
        ratingStack.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(70)
            make.height.equalTo(25)
            make.top.equalTo(genres.snp.bottom).offset(29)
        }
        segmentControl.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(ratingStack.snp.bottom).offset(40)
            make.height.equalTo(36)
        }
        
    }
    
    override func configure(model: Movies, genres: [String] = [], image: UIImage = UIImage(), cast: [Cast] = [], photos: [UIImage]? = [], videos: [UIImage]? = []) {
        title.text = model.title
        rating.text = "\(round(model.voteAverage / 2 * 10) / 10)/5"
        self.genres.text = genres.joined(separator: ", ")
        starStack.makeStarRating(of: model.voteAverage)
        posterImage.image = image
    }
}
