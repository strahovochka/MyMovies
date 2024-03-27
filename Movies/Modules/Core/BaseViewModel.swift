//
//  BaseViewModel.swift
//  Movies
//
//  Created by Jane Strashok on 22.03.2024.
//

import UIKit

protocol BaseViewModelDelegate: AnyObject {
    func reloadData()
}

class BaseViewModel {
    weak var delegate: BaseViewModelDelegate?
    let networkManager = NetworkManager.shared
    
    init(delegate: BaseViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loadImageWith(api: MoviesAPI, completition: @escaping (UIImage?) -> Void) {
        let dispatchQueue = DispatchQueue(label: "com.load.image")
        if let imageUrl = URL(string: api.pass) {
            dispatchQueue.async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        completition(UIImage(data: imageData))
                    }
                }
            }
        }
    }
    
}
