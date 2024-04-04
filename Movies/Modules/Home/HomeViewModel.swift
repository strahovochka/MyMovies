//
//  HomeViewModel.swift
//  Movies
//
//  Created by Jane Strashok on 21.03.2024.
//

import UIKit

enum ModelState {
    case common
    case search(String)
}

final class HomeViewModel: BaseViewModel {
    private var nowMoviesModel: [Movies] = []
    private var soonMoviesModel: [Movies] = []
    private var genres: [Int : String] = [:]
    private var images: [Int : UIImage?] = [:] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadData()
            }
        }
    }
    
    private var currentType: MoviesType = .now {
        didSet {
            self.delegate?.reloadData()
        }
    }
    private var currentState: ModelState = .common {
        didSet {
            self.delegate?.reloadData()
        }
    }
    
    func getContent() async {
        await withCheckedContinuation { continuation in
            NetworkManager.shared.fetchComingNow { [weak self] response in
                guard let self = self else { return }
                switch response {
                case let .success(movies):
                    self.nowMoviesModel = movies
                    self.getImages(for: movies)
                case let .error(descr):
                    print(descr)
                
                }
            }
            NetworkManager.shared.fetchComingSoon { [weak self] response in
                guard let self = self else { return }
                switch response {
                case let .success(movies):
                    self.soonMoviesModel = movies
                    self.getImages(for: movies)
                case let .error(descr):
                    print(descr)
                
                }
            }
            NetworkManager.shared.fetchGenres { [weak self] response in
                guard let self = self else { return }
                switch response {
                case let .success(genres):
                    self.genres = genres
                case let .error(descr):
                    print(descr)
                }
                continuation.resume()
            }
        }
    }
    
    private func getImages(for movies: [Movies]) {
        movies.forEach { movie in
            loadImageWith(api: .poster(movie.posterPath)) { [weak self] image in
                guard let self = self else { return }
                self.images[movie.id] = image
            }
        }
    }
    
    func toggleCurrentType() {
        switch currentType {
        case .now:
            currentType = .soon
        case .soon:
            currentType = .now
        }
    }
    
    func setCurrentState(_ state: ModelState) {
        self.currentState = state
    }
    
    func getCurrentModel() -> [Movies] {
        switch currentState {
        case .common:
            switch currentType {
            case .now:
                return nowMoviesModel
            case .soon:
                return soonMoviesModel
            }
        case .search(let text):
            var res: [Movies] = []
            switch currentType {
            case .now:
                res = nowMoviesModel
            case .soon:
                res = soonMoviesModel
            }
            return text == "" ? res : res.filter { $0.title.localizedCaseInsensitiveContains(text) }
        }
    }
    
    func getGenreName(for genreIds: [Int]) -> String? {
        var res: [String] = []
        genreIds.forEach {
            if let name = genres[$0] {
                res.append(name)
            }
        }
        return res.first
    }
    
    func getGenresNames(for genreIds: [Int]) -> [String] {
        var res: [String] = []
        genreIds.forEach {
            if let name = genres[$0] {
                res.append(name)
            }
        }
        return res
    }
    
    func getImageFor(id: Int) -> UIImage? {
        images[id] ?? UIImage()
    }
    
}


