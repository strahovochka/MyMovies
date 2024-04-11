//
//  ReviewCell.swift
//  Movies
//
//  Created by Jane Strashok on 09.04.2024.
//

import UIKit
import SnapKit

class ReviewCell: BaseTableViewCell {
    
    lazy var allStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    lazy var allView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var contentStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.backgroundColor = UIColor(hex: "2B3543")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 19, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    lazy var starStack: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var contenLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .plainText()
        label.numberOfLines = 4
        return label
    }()
    
    lazy var triangle: UIImageView = {
        var view = UIImageView()
        view.image = .triangleForReviews()
        view.tintColor = UIColor(hex: "2B3543")
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        var view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var authorNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    lazy var dateCreatedLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .unselectedText()
        return label
    }()
    
    override func configureView() {
        super.configureView()
        contentStackView.addArrangedSubview(starStack)
        contentStackView.addArrangedSubview(contenLabel)
        allView.addSubview(contentStackView)
        allView.addSubview(triangle)
        allView.addSubview(profileImage)
        allView.addSubview(authorNameLabel)
        allView.addSubview(dateCreatedLabel)
        allStackView.addArrangedSubview(allView)
        addSubview(allStackView)
    }
    
    override func makeContraints() {
        allStackView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        contentStackView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        triangle.snp.remakeConstraints { make in
            make.top.equalTo(contentStackView.snp.bottom)
            make.width.equalTo(18)
            make.height.equalTo(16)
            make.leading.equalTo(contentStackView).inset(27)
        }
        profileImage.snp.remakeConstraints { make in
            make.top.equalTo(triangle.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.height.width.equalTo(40)
        }
        authorNameLabel.snp.remakeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.top.equalTo(profileImage)
        }
        dateCreatedLabel.snp.remakeConstraints { make in
            make.top.equalTo(authorNameLabel.snp.bottom).offset(2)
            make.leading.equalTo(authorNameLabel)
        }
    }
    
    func configure(with review: Review) {
        self.starStack.makeStarRating(of: review.rating)
        self.contenLabel.text = "some text"
        self.profileImage.image = review.profileImage
        self.authorNameLabel.text = review.name
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: review.dateCreated) {
            formatter.dateStyle = .short
            self.dateCreatedLabel.text = formatter.string(from: date)
        } else {
            self.dateCreatedLabel.text = "Unknown"
        }
    }
}
