//
//  Response.swift
//  Movies
//
//  Created by Jane Strashok on 19.03.2024.
//

import Foundation

enum Response<T> {
    case success(T)
    case error(String)
}
