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
            return res.filter { $0.title.replacingOccurrences(of: " ", with: "").lowercased().contains(text.lowercased()) }
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


