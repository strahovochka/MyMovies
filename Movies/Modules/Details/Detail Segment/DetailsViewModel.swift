//
//  DetailsViewModel.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit
import AVFoundation

final class DetailsViewModel {
    private(set) var movie: Movies 
    private(set) var genres: [String]
    private(set) var image: UIImage
    private(set) var cast: [Cast]?
    private(set) var photos: [UIImage]?
    private(set) var videos: (keys: [String], previews: [UIImage])?
    
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
                let urls = cast.map { URL(string: "\(MoviesAPI.poster($0.profilePath).pass)")}
                self.loadImages(urls: urls) { images in
                    if let images = images {
                        for i in 0..<images.count {
                            self.cast?[i].profileImage = images[i]
                        }
                    }
                }
            case .error(let descr):
                print(descr)
            }
        }
        NetworkManager.shared.fetchPhotosData(with: .photos(movie.id)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let photosPaths):
                let urls = photosPaths.map { URL(string: "\(MoviesAPI.poster($0).pass)")}
                self.loadImages(urls: urls) { images in
                    self.photos = images
                }
            case .error(let descr):
                print(descr)
            }
        }
        NetworkManager.shared.fetchVideoData(with: .videos(movie.id)) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let keys):
                let urls = keys.map { URL(string: "https://img.youtube.com/vi/\($0)/0.jpg") }
                self.loadImages(urls: urls) { images in
                    if let images = images {
                        self.videos = (keys, images)
                    }
                }
            case .error(let descr):
                print(descr)
            }
        }
    }
    
    func loadImages(urls: [URL?], completion: @escaping ([UIImage]?) -> Void) {
        var loadedImages: [UIImage] = Array.init(repeating: UIImage(), count: urls.count)
        let dispatchGroup = DispatchGroup()
        
        for i in 0..<urls.count {
            if let url = urls[i] {
                dispatchGroup.enter()
                URLSession.shared.dataTask(with: url) { data, response, error in
                    defer {
                        dispatchGroup.leave()
                    }
                    
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                        return
                    }
                    
                    if let data = data, let image = UIImage(data: data) {
                        loadedImages[i] = image
                    } else {
                        print("Failed to create UIImage from data.")
                    }
                }.resume()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(loadedImages)
            self.delegate?.reloadData()
        }
    }
        
}
