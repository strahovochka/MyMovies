//
//  DetailsView.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit
import SnapKit

class DetailsView: UIView {
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.register(DetailsCellType.main.cell)
        tableView.register(DetailsCellType.synopsis.cell)
        tableView.register(DetailsCellType.castAndCrew.cell)
        tableView.register(DetailsCellType.photos.cell)
        tableView.register(DetailsCellType.videos.cell)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView() {
        addSubview(tableView)
    }
    
    func makeConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(18)
        }
    }
}
