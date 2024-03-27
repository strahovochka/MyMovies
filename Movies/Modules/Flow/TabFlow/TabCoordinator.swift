//
//  TabCoordinator.swift
//  Movies
//
//  Created by Jane Strashok on 21.03.2024.
//

import UIKit

enum TabItem: Int, CaseIterable {
    case home
    case ticket
    case notifications
    case profile
    
    var controller: UIViewController {
        switch self {
        case .home:
            return HomeViewController(controllerType: self)
        default:
            return UIViewController()
        }
    }
    
    var tabImage: UIImage? {
        switch self {
        case .home:
            return .homeTab()
        case .ticket:
            return .ticketTab()
        case .notifications:
            return .notificationsTab()
        case .profile:
            return .profileTab()
        }
    }

}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectTab(_ tab: TabItem)
    func setSelectedIndex(_ index: Int)
    func currentTab() -> TabItem?
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    var childCoordinators: [Coordinator] = []
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
        self.tabBarController.tabBar.backgroundColor = .backgroundColor()
        self.tabBarController.tabBar.layer.borderColor = UIColor(hex: "2B3543").cgColor
        self.tabBarController.tabBar.layer.borderWidth = 1
    }
    
    func start() {
        let tabs = TabItem.allCases
        let controllers: [UINavigationController] = tabs.map { getTabController($0) }
        prepareTabBarController(withTabControllers: controllers)
        if let items = tabBarController.tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
            }
        }
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabItem.home.rawValue
        tabBarController.tabBar.isTranslucent = false
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ item: TabItem) -> UINavigationController {
        let nav = UINavigationController()
        nav.setNavigationBarHidden(false, animated: false)
        
        nav.tabBarItem = UITabBarItem(title: nil, image: item.tabImage, tag: item.rawValue)
        
        nav.pushViewController(item.controller, animated: true)
        
        return nav
    }
    
    func selectTab(_ tab: TabItem) {
        tabBarController.selectedIndex = tab.rawValue
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let tab = TabItem.init(rawValue: index) else { return }
        tabBarController.selectedIndex = tab.rawValue
    }
    
    func currentTab() -> TabItem? {
        TabItem.init(rawValue: tabBarController.selectedIndex)
    }
    
}

extension TabCoordinator: UITabBarControllerDelegate {
    
}
