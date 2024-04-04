//
//  NetworkManager.swift
//  Movies
//
//  Created by Jane Strashok on 19.03.2024.
//

import UIKit

class NetworkManager: NetworkProtocol {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchComingNow(completition: @escaping (Response<[Movies]>) -> Void) {
        fetchMovies(.comingNow, completition: completition)
    }
    
    func fetchComingSoon(completition: @escaping (Response<[Movies]>) -> Void) {
        fetchMovies(.comingSoon, completition: completition)
    }
    
    func fetchCreditsForMovieWith(id movieId: Int, completition: @escaping (Response<[Cast]>) -> Void) {
        let api: MoviesAPI = .cast(movieId)
        guard let url = URL(string: "\(baseURL)\(api.pass)\(api.queryParameters)") else { return }
        var res: [Cast] = []
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let castData = json?["cast"] as? [[String: Any]] {
                        for cast in castData {
                            if let name = cast["name"] as? String,
                               let profilePath = cast["profile_path"] as? String,
                               let charachter = cast["character"] as? String {
                                res.append(Cast(name: name, profilePath: profilePath, character: charachter))
                            }
                        }
                        completition(.success(res))
                    }
                } catch {
                    completition(.error(error.localizedDescription))
                }
            }
        }.resume()
                
    }
    
    func fetchGenres(completition: @escaping (Response<[Int: String]>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(MoviesAPI.genres.pass)\(MoviesAPI.genres.queryParameters)") else { return }
        var res: [Int: String] = [:]
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    if let genresData = json?["genres"] as? [[String : Any]] {
                        for genreData in genresData {
                            if let id = genreData["id"] as? Int,
                               let name = genreData["name"] as? String {
                                res[id] = name
                            }
                        }
                        completition(.success(res))
                    }
                } catch {
                    completition(.error(error.localizedDescription))
                }
            } else {
                completition(.error("No data acquired"))
            }
        }.resume()
    }
    
    private func fetchMovies(_ moviesAPI: MoviesAPI, completition: @escaping (Response<[Movies]>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(moviesAPI.pass)\(moviesAPI.queryParameters)") else { return }
        var res: [Movies] = []
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    if let movies = json?["results"] as? [[String : Any]] {
                        for moviesData in movies {
                            if let backPath = moviesData["backdrop_path"] as? String,
                               let genreIds = moviesData["genre_ids"] as? [Int],
                               let id = moviesData["id"] as? Int,
                               let overview = moviesData["overview"] as? String,
                               let posterPath = moviesData["poster_path"] as? String,
                               let title = moviesData["title"] as? String,
                               let voteAverage = moviesData["vote_average"] as? Double {
                                res.append(Movies(posterPath: posterPath, genreIds: genreIds, id: id, backdropPath: backPath, overview: overview, title: title, voteAverage: voteAverage))
                            }
                        }
                        completition(.success(res))
                    } else {
                        completition(.error("Incorrect json structure"))
                    }
                } catch {
                    completition(.error(error.localizedDescription))
                }
            } else {
                completition(.error("No data acquired"))
                return
            }
        }.resume()
    }
    
    func fetchPhotosData(with api: MoviesAPI, completition: @escaping (Response<[String]>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(api.pass)\(api.queryParameters)") else { completition(.error("Unable to form url "))
            return
        }
        let request = URLRequest(url: url)
        var res: [String] = []
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    if let backdrops = json?["backdrops"] as? [[String : Any]] {
                        for drop in backdrops {
                            if let filePath = drop["file_path"] as? String {
                                res.append(filePath)
                            } else {
                                completition(.error("Error parsing JSON"))
                            }
                        }
                        completition(.success(res))
                    } else {
                        completition(.error("Error parsing JSON"))
                    }
                } catch {
                    completition(.error(error.localizedDescription))
                }
            } else {
                completition(.error("No data acquired"))
            }
        }.resume()
        
    }
}
