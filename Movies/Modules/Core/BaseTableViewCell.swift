//
//  BaseTableViewCell.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    static func cellIdn() -> String {
        String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        makeContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView() {
        
    }
    
    func makeContraints() {
        
    }
    
}
