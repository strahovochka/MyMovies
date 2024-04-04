//
//  PhotosCell.swift
//  Movies
//
//  Created by Jane Strashok on 04.04.2024.
//

import UIKit
import SnapKit

class PhotosCell: DetailsCell {
    
    lazy var title: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.text = "Photos"
        return label
    }()
    
    lazy var viewAllButton: UIButton = {
        var button = UIButton()
        button.setTitle("View all", for: .normal)
        button.setTitleColor(.accentColor(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(PhotoCollectionViewCell.self)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private var photos: [UIImage] = []
    
    override func configureView() {
        super.configureView()
        addSubview(title)
        addSubview(viewAllButton)
        contentView.addSubview(collectionView)
    }
    
    override func makeContraints() {
        title.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.equalToSuperview()
        }
        viewAllButton.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.trailing.equalToSuperview()
        }
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configure(model: Movies, genres: [String] = [], image: UIImage = UIImage(), cast: [Cast] = [], photos: [UIImage]? = []) {
        if let photos = photos {
            self.photos = photos
            self.collectionView.reloadData()
        }
    }
    
}

extension PhotosCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellIdn(), for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell () }
        cell.imageView.image = photos[indexPath.row]
        cell.isUserInteractionEnabled = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: screenSize.width/3 - 21, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //TODO: make transition to all photos screen
    }
    
}
