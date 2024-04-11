//
//  ReviewsCell.swift
//  Movies
//
//  Created by Jane Strashok on 09.04.2024.
//

import UIKit
import SnapKit

class ReviewsCell: DetailsCell {
    lazy var reviewsCountTitle: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .unselectedText()
        return label
    }()
    
    lazy var tableView: CustomTableView = {
        var view = CustomTableView()
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.sectionHeaderTopPadding = 0
        view.separatorColor = .clear
        view.register(ReviewCell.self)
        view.estimatedRowHeight = UITableView.automaticDimension
        return view
    }()
    
    private var reviews: [Review]?
    
    override func configureView() {
        super.configureView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(reviewsCountTitle)
        addSubview(tableView)
    }
    
    override func makeContraints() {
        reviewsCountTitle.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(32)
        }
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(reviewsCountTitle.snp.bottom).offset(32)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configure(model: DetailsViewModel) {
        if let reviews = model.reviews {
            self.reviews = reviews
            self.reviewsCountTitle.text = "\(reviews.count) \(reviews.count == 1 ? "Review" : "Reviews")"
        }
    }
}

extension ReviewsCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        reviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.cellIdn(), for: indexPath) as? ReviewCell else { return UITableViewCell() }
        if let reviews = reviews {
            cell.configure(with: reviews[indexPath.section])
            print(cell.frame.height)
            print(tableView.contentSize)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        24
    }
}
