//
//  ViewMoreModel.swift
//  Movies
//
//  Created by Jane Strashok on 08.04.2024.
//

import UIKit

final class ViewMoreModel {
    
    private(set) var cast: [Cast]
    private(set) var photos: [UIImage]
    private(set) var videos: (keys: [String], previews: [UIImage])
    
    init(cast: [Cast], photos: [UIImage], videos: (keys: [String], previews: [UIImage])) {
        self.cast = cast
        self.photos = photos
        self.videos = videos
    }
}
