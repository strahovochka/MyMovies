//
//  HomeViewController.swift
//  Movies
//
//  Created by Jane Strashok on 21.03.2024.
//

import UIKit
import SnapKit

enum MoviesType: String, CaseIterable {
    case now = "Now Showing"
    case soon = "Coming Soon"
}

class HomeViewController: UIViewController {

    lazy var mainView: HomeView = {
        let view = HomeView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        return view
    }()
    
    lazy var viewModel: HomeViewModel = {
        var model = HomeViewModel(delegate: self)
        return model
    }()
    
    init(controllerType: TabItem) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: nil, image: controllerType.tabImage, selectedImage: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        viewModel.getContent()
        self.view = mainView
        self.view.backgroundColor = .backgroundColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
    }
}

//MARK: -CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCurrentModel().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellIdn(), for: indexPath) as? MovieCell else { return UICollectionViewCell() }
        
        let movie = viewModel.getCurrentModel()[indexPath.row]
        
        cell.configureCell(model: movie)
        cell.genreAndTime.text = viewModel.getGenreName(for: movie.genreIds)
        viewModel.loadImageWith(api: .poster(viewModel.getCurrentModel()[indexPath.row].posterPath)) { image in
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: screenSize.width/2 - 24, height: screenSize.height * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 6, bottom: 0, right: 6)
    }
}

private extension HomeViewController {
    func setUpNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "Star Movie"
    }
}



extension HomeViewController: BaseViewModelDelegate {
    func reloadData() {
        self.mainView.collectionView.reloadData()
    }
}
