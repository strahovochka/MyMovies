//
//  HomeViewModel.swift
//  Movies
//
//  Created by Jane Strashok on 21.03.2024.
//

import UIKit

final class HomeViewModel: BaseViewModel {
    private var nowMoviesModel: [Movies] = []
    private var soonMoviesModel: [Movies] = []
    private var genres: [Int : String] = [:]
    
    private var currentType: MoviesType = .now
    
    func getContent() {
        networkManager.fetchComingNow { [weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(movies):
                self.nowMoviesModel = movies
            case let .error(descr):
                print(descr)
            
            }
        }
        networkManager.fetchComingSoon { [weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(movies):
                self.soonMoviesModel = movies
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
    
    func getCurrentModel() -> [Movies] {
        switch currentType {
        case .now:
            return nowMoviesModel
        case .soon:
            return soonMoviesModel
        }
    }
    
    func getGenreName(for genreIds: [Int]) -> String? {
        var res: [String] = []
        print(genres)
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
    
}


