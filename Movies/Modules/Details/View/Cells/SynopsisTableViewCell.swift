//
//  SynopsisCell.swift
//  Movies
//
//  Created by Jane Strashok on 02.04.2024.
//

import UIKit
import SnapKit

protocol SynopsisDelegate {
    func reloadData()
}

class SynopsisTableViewCell: DetailsCell {
    
    lazy var stack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()
    
    lazy var title: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Synopsis"
        label.textColor = .white
        return label
    }()
    
    lazy var content: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .plainText()
        label.numberOfLines = 4
        return label
    }()
    
    lazy var showMoreButton: UIButton = {
        var button = UIButton()
        button.setTitle("Show more", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.titleLabel?.textColor = .accentColor()
        button.addTarget(self, action: #selector(showButtonTouched), for: .touchUpInside)
        button.tintColor = .green
        return button
    }()
    
    var isShowingMore = false
    var delegate: SynopsisDelegate?
    
    override func configureView() {
        super.configureView()
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(content)
        contentView.addSubview(stack)
    }
    
    override func makeContraints() {
        stack.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(32)
        }
        title.snp.remakeConstraints { make in
            make.height.equalTo(44)
        }
        showMoreButton.snp.remakeConstraints { make in
            make.height.equalTo(30)
        }
        stack.addArrangedSubview(showMoreButton)
    }
    
    override func configure(model: Movies, genres: [String] = [], image: UIImage = UIImage()) {
        content.text = model.overview
    }
    
    @objc func showButtonTouched() {
        if content.numberOfLines > 0 {
            content.numberOfLines = 0
            showMoreButton.setTitle("Show less", for: .normal)
        } else {
            content.numberOfLines = 4
            showMoreButton.setTitle("Show more", for: .normal)
        }
        isShowingMore.toggle()
        delegate?.reloadData()
    }
}
