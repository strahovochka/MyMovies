//
//  ViewMoreCell.swift
//  Movies
//
//  Created by Jane Strashok on 08.04.2024.
//

import UIKit

enum ViewAllOptions {
    case cast
    case photos
    case videos
    
    var title: String {
        switch self {
        case .cast:
            return "Cast & Crew"
        case .photos:
            return "Photos"
        case .videos:
            return "Videos"
        }
    }
    
    var cell: ViewMoreCell.Type {
        switch self {
        case .cast:
            return CastMemberCell.self
        case .photos:
            return PhotoCell.self
        case .videos:
            return ViewMoreCell.self
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .cast:
            return 48
        case .photos, .videos:
            return 224
        }
    }
    
    var headerHeight: CGFloat {
        switch self {
        case .cast:
            return 20
        case .photos, .videos:
            return 12
        }
    }
}

class ViewMoreCell: BaseTableViewCell {
    
    override func configureView() {
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        super.layoutSubviews()
    }
    
    func configure(castMember: Cast? = nil, photo: UIImage = UIImage(), videoPreview: (String, UIImage) = ("", UIImage())) {
        
    }
}
