//
//  NetworkProtocol.swift
//  Movies
//
//  Created by Jane Strashok on 19.03.2024.
//

import Foundation

protocol NetworkProtocol {
    func fetchComingNow(completition: @escaping (Response<[Movies]>) -> Void)
    func fetchComingSoon(completition: @escaping (Response<[Movies]>) -> Void)
    func fetchGenres(completition: @escaping (Response<[Int: String]>) -> Void)
}
