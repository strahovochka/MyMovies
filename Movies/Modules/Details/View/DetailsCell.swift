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
            return PosterCell.self
        case .synopsis:
            return SynopsisCell.self
        case .castAndCrew:
            return CastTableViewCell.self
        case .photos:
            return PhotosCell.self
        default:
            return DetailsCell.self
        }
    }
    
    var heightForRow: CGFloat {
        switch self {
        case .main:
            return 520
        case .synopsis:
            return 142
        case .castAndCrew:
            return 338
        case .photos:
            return 142
        default:
            return 100
        }
    }
}

enum ViewAllOptions {
    case cast
    case photos
    case videos
}

protocol DetailsDelegate {
    func showMoreToggled(start: Bool)
    func viewAll(ofType type: ViewAllOptions)
}

class DetailsCell: BaseTableViewCell {
    
    var delegate: DetailsDelegate?
    
    override func configureView() {
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        super.layoutSubviews()
    }
    
    func configure(model: Movies, genres: [String] = [], image: UIImage = UIImage(), cast: [Cast] = [], photos: [UIImage]? = []) {
        
    }
    
    func getHeight() -> CGFloat {
        return 0
    }
}
