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

class HomeViewController: BaseViewController {

    lazy var mainView: HomeView = {
        let view = HomeView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.searchBar.delegate = self
        if let searchField = view.searchBar.value(forKey: "searchField") as? UITextField, let close = searchField.value(forKey: "_clearButton") as? UIButton {
            close.addTarget(self, action: #selector(closeSearch), for: .touchUpInside)
        }
        view.segmentControl.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
        return view
    }()
    
    lazy var viewModel: HomeViewModel = {
        var model = HomeViewModel(delegate: self)
//        viewModel.getContent()
        return model
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.subviews.forEach({ view in
            if view is UIButton {
                view.removeFromSuperview()
            }
        })
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.layoutIfNeeded()
        closeSearch(duration: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeSearch(duration: 0.2)
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
        cell.imageView.image = viewModel.getImageFor(id: movie.id)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: screenSize.width/2 - 24, height: screenSize.height * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 24, left: 6, bottom: 0, right: 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = viewModel.getCurrentModel()[indexPath.row]
        let genres = viewModel.getGenresNames(for: object.genreIds)
        let image = viewModel.getImageFor(id: object.id) ?? UIImage()
        self.flowDelegate?.showDetails(object: object, genres: genres, image: image)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.setCurrentState(.search(searchText))
        self.reloadData()
    }
    
}

private extension HomeViewController {
    func setUpNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "Star Movie"
        
        let button = UIButton()
        button.setImage(.searchIcon(), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(openSearch), for: .touchUpInside)
    
        self.navigationController?.navigationBar.addSubview(button)
        button.snp.remakeConstraints { make in
            make.height.width.equalTo(24)
            make.trailing.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(18)
        }
    }
    
    @objc func openSearch() {
        mainView.searchBar.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
            self.navigationController?.navigationBar.subviews.forEach({ view in
                if view is UIButton {
                    view.isHidden = true
                }
            })
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.mainView.searchBar)
            self.mainView.searchBar.placeholder = "Search"
            self.mainView.searchBar.alpha = 1
        } completion: { finished in
            self.mainView.searchBar.becomeFirstResponder()
        }

    }
    
    @objc func closeSearch(duration: TimeInterval = 0.2) {
        UIView.animate(withDuration: duration) {
            self.mainView.searchBar.alpha = 0.5
        } completion: { finished in
            self.navigationItem.setLeftBarButton(nil, animated: true)
            self.navigationController?.navigationBar.subviews.forEach({ view in
                if view is UIButton {
                    view.isHidden = false
                }
            })
        }
        self.viewModel.setCurrentState(.common)
        
    }
    
    @objc func valueChanged(_ sender: UISegmentedControl) {
        self.viewModel.toggleCurrentType()
    }
}

extension HomeViewController: BaseViewModelDelegate {
    func reloadData() {
        self.mainView.collectionView.reloadData()
    }
}
