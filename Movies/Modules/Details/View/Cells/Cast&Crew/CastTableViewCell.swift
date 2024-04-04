//
//  CastTableViewCell.swift
//  Movies
//
//  Created by Jane Strashok on 02.04.2024.
//

import UIKit
import SnapKit

protocol CastDelegate {
    func viewAll()
}

class CastTableViewCell: DetailsCell {
    lazy var title: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "Cast & Crew"
        return label
    }()
    
    lazy var viewAllButton: UIButton = {
        var button = UIButton()
        button.setTitle("View all", for: .normal)
        button.setTitleColor(.accentColor(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    lazy var stack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.alignment = .leading
        return stack
    }()
    
    
    var delegate: CastDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stack.removeAllArrangedSubviews()
    }
    
    override func configureView() {
        super.configureView()
        addSubview(title)
        addSubview(viewAllButton)
    }
    
    override func makeContraints() {
        title.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview()
        }
        viewAllButton.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview()
        }
    }
    
    override func configure(model: Movies, genres: [String] = [], image: UIImage = UIImage(), cast: [Cast] = []) {
        for i in 0..<4 {
            if !cast.isEmpty {
                let member = cast[i]
                let view = CastMemberView()
                view.configure(with: member)
                stack.addArrangedSubview(view)
            }
        }
        addSubview(stack)
        stack.snp.remakeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(24)
            make.leading.bottom.trailing.equalToSuperview()
            
        }
    }
}

private extension CastTableViewCell {
    @objc func viewAllButtonTouched() {
        delegate?.viewAll()
    }
}
