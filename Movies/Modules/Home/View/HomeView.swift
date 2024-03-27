//
//  HomeView.swift
//  Movies
//
//  Created by Jane Strashok on 25.03.2024.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    lazy var segmentControl: CustomSegmentControl = {
        var view = CustomSegmentControl(items: MoviesType.allCases.map({$0.rawValue}))
        let unselectedTextStyle: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.unselectedText(),
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let selectedTextStyle: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14, weight: .bold)
        ]
        view.setTitleTextAttributes(unselectedTextStyle, for: .normal)
        view.setTitleTextAttributes(selectedTextStyle, for: .selected)

        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(MovieCell.self)
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        var bar = UISearchBar()
        bar.backgroundColor = .clear
        let searchBarSize = CGSize(width: screenSize.width - 36, height: 24)
        bar.frame = CGRect(origin: .zero, size: searchBarSize)
        bar.searchTextField.textColor = .white
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureView() {
        addSubview(segmentControl)
        addSubview(collectionView)
    }
    
    func makeConstraints() {
        segmentControl.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(40)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
        }
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
    }

}
