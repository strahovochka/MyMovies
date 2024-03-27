//
//  MoviesAPI.swift
//  Movies
//
//  Created by Jane Strashok on 19.03.2024.
//

import Foundation

enum MoviesAPI {
    case comingNow
    case comingSoon
    case poster(String)
    case genres
    
    var pass: String {
        switch self {
        case .comingNow:
            return "/movie/now_playing"
        case .comingSoon:
            return "/movie/upcoming"
        case let .poster(path):
            return "https://image.tmdb.org/t/p/w500//\(path)"
        case .genres:
            return "/genre/movie/list"
        }
    }
    
    var queryParameters: String {
        "?api_key=7a28914ce5fa9a66a4ceb7740e49ebcd"
    }
}
