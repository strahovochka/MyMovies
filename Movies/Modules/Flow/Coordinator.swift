//
//  Coordinator.swift
//  Movies
//
//  Created by Jane Strashok on 19.03.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    init (_ navigationController: UINavigationController)
}
