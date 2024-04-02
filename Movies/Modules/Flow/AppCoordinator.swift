//
//  AppCoordinator.swift
//  Movies
//
//  Created by Jane Strashok on 19.03.2024.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showMainFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        showMainFlow()
    }
    
    func showMainFlow() {
        let tabCoordinator = TabCoordinator(navigationController)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
    
}
