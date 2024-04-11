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
        case .photos, .videos:
            return MediaCell.self
        case .reviews:
            return ReviewsCell.self
            
        default:
            return DetailsCell.self
        }
    }
    
    var heightForRow: CGFloat {
        switch self {
        case .main:
            return 520
        case .synopsis:
            return UITableView.automaticDimension
        case .photos, .videos:
            return 142
        case .castAndCrew:
            return 338
        case .reviews:
            return UITableView.automaticDimension
        default:
            return 100
        }
    }
}

protocol DetailsDelegate {
    func showMoreToggled(start: Bool)
    func viewAll(ofType type: ViewAllOptions, scrollTo indexPath: IndexPath?)
    func segmentValueChanged(sender: CustomSegmentControl)
    func reloadData()
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
    
    func configure(model: DetailsViewModel) {
        
    }
}
