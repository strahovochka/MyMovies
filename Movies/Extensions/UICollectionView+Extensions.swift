//
//  UICollectionView+Extensions.swift
//  Movies
//
//  Created by Jane Strashok on 26.03.2024.
//

import Foundation
import UIKit

let screenSize = UIScreen.main.bounds

extension UICollectionView {
    func register(_ cell: BaseCollectionViewCell.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.cellIdn())
    }
}


