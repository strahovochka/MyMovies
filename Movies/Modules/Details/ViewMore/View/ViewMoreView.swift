//
//  ViewMoreView.swift
//  Movies
//
//  Created by Jane Strashok on 08.04.2024.
//

import UIKit
import SnapKit

class ViewMoreView: UIView {
    
    lazy var tableView: UITableView = {
        var view = UITableView()
        view.backgroundColor = .clear
        view.register(CastMemberCell.self)
        view.register(PhotoCell.self)
        view.sectionHeaderTopPadding = 0
        return view
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
        addSubview(tableView)
    }
    
    func makeContraints() {
        tableView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(18)
        }
    }
    
}
