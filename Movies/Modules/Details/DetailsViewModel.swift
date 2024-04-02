//
//  DetailsViewModel.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit

final class DetailsViewModel {
    private(set) var movie: Movies
    private(set) var genres: [String]
    private(set) var image: UIImage
    
    init (movie: Movies, genres: [String], image: UIImage) {
        self.movie = movie
        self.genres = genres
        self.image = image
    }
}
