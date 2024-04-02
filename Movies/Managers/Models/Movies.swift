//
//  Movie.swift
//  Movies
//
//  Created by Jane Strashok on 19.03.2024.
//

import UIKit

struct Movies: Codable {
    var posterPath: String
    var genreIds: [Int]
    var id: Int
    
    let backdropPath: String
    let overview: String?
    let title: String
    let voteAverage: Double
}
