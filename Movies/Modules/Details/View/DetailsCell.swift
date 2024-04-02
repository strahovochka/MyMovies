//
//  DetailsCell.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit

enum DetailsCellType {
    case main
    case synopsis
    case castAndCrew
    case photos
    case videos
    case blogs
    case reviews
    case dateChoose
    case chooseCinema
    case chooseDate
    
    var cell: DetailsCell.Type {
        switch self {
        case .main:
            return PosterTableViewCell.self
        case .synopsis:
            return SynopsisTableViewCell.self
        default:
            return DetailsCell.self
        }
    }
    
    var heightForRow: CGFloat {
        switch self {
        case .main:
            return 517
        case .synopsis:
            return 142
        default:
            return 100
        }
    }
}

class DetailsCell: BaseTableViewCell {
    override func configureView() {
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        super.layoutSubviews()
    }
    
    func configure(model: Movies, genres: [String] = [], image: UIImage = UIImage()) {
        
    }
}
