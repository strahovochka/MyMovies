//
//  BaseViewController.swift
//  Movies
//
//  Created by Jane Strashok on 27.03.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
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

}
