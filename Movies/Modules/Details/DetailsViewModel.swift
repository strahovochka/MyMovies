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
    private(set) var cast: [Cast]?
    
    weak var delegate: BaseViewModelDelegate?
    
    init (movie: Movies, genres: [String], image: UIImage) {
        self.movie = movie
        self.genres = genres
        self.image = image
    }
    
    func getContent()  {
        NetworkManager.shared.fetchCreditsForMovieWith(id: movie.id) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let cast):
                self.cast = cast
                self.loadImages(for: cast)
            case .error(let descr):
                print(descr)
            }
        }
    }
    
    func loadImages(for cast: [Cast]) {
        let dispacthGroup = DispatchGroup()
        let queue = DispatchQueue(label: "com.download.images", attributes: .concurrent)
        var res: [Data] = Array<Data>.init(repeating: Data(), count: cast.count)
        for i in 0..<cast.count {
            let member = cast[i]
            if let url = URL(string: MoviesAPI.poster(member.profilePath).pass) {
                dispacthGroup.enter()
                queue.async {
                    if let data = try? Data(contentsOf: url) {
                        res[i] = data
                        dispacthGroup.leave()
                    }
                }
            }
        }
        
        dispacthGroup.notify(queue: .main) {
            for i in 0..<(self.cast?.count ?? 0) {
                self.cast?[i].profileImage = UIImage(data: res[i])
            }
            self.delegate?.reloadData()
        }
    }
        
}
