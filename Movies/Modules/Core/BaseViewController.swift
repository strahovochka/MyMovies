//
//  BaseViewController.swift
//  Movies
//
//  Created by Jane Strashok on 27.03.2024.
//

import UIKit

protocol BaseViewControllerDelegate: AnyObject {
    func showDetails(object: Movies, genres: [String], image: UIImage)
}

class BaseViewController: UIViewController {
    
    weak var flowDelegate: BaseViewControllerDelegate?
    
    init(controllerType: TabItem) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: nil, image: controllerType.tabImage, selectedImage: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func setUpNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         navigationController?.navigationBar.shadowImage = UIImage()
    }

}
