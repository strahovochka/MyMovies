//
//  Movie.swift
//  Movies
//
//  Created by Jane Strashok on 19.03.2024.
//

import Foundation

struct Movies: Codable {
    var posterPath: String?
    var originalTitle: String?
    var genreIds: [Int]?
    var id: Int
    
    let backdropPath: String?
    let originalLanguage: String?
    let overview: String?
    let runtime: Int?
    let title: String?
    let voteAverage: Double?
}
