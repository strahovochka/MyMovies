//
//  UITableView+Extensions.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit

extension UITableView {
    func register(_ cell: BaseTableViewCell.Type) {
        self.register(cell, forCellReuseIdentifier: cell.cellIdn())
    }
}
