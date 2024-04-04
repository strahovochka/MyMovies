//
//  VideoCollectioViewCell.swift
//  Movies
//
//  Created by Jane Strashok on 04.04.2024.
//

import Foundation
import YouTubeiOSPlayerHelper
import SnapKit

class VideoCollectionViewCell: BaseCollectionViewCell {
    
    lazy var playerView: YTPlayerView = {
        var view = YTPlayerView()
        return view
    }()
    
    override func configureView() {
        super.configureView()
        contentView.addSubview(playerView)
    }
    
    override func makeConstraints() {
        playerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
