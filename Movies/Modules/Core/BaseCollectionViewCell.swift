//
//  BaseCollectionViewCell.swift
//  Movies
//
//  Created by Jane Strashok on 26.03.2024.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    static func cellIdn() -> String {
        String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView() {
        self.backgroundColor = .clear
    }
    
    func makeConstraints() {
        
    }
    
}
