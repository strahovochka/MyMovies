//
//  DetailsViewController.swift
//  Movies
//
//  Created by Jane Strashok on 28.03.2024.
//

import UIKit

enum DetailsViewType: String, CaseIterable {
    case detail = "Detail"
    case reviews = "Reviews"
    case showtime = "Showtime"
    
    var cells: [DetailsCellType] {
        switch self {
        case .detail:
            return [.main, .synopsis, .castAndCrew, .photos, .videos, .blogs]
        case .reviews:
            return [.main, .reviews]
        case .showtime:
            return [.main, .dateChoose, .chooseCinema]
        }
    }
}

final class DetailsViewController: BaseViewController {
    
    lazy var mainView: DetailsView = {
        var view = DetailsView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        //view.tableView.estimatedRowHeight = UITableView.automaticDimension
        return view
    }()
    
    var viewModel: DetailsViewModel
    private var currentType: DetailsViewType = .detail
    
    init(object: Movies, genres: [String], image: UIImage) {
        self.viewModel = DetailsViewModel(movie: object, genres: genres, image: image)
        super.init(controllerType: .home)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        self.view.backgroundColor = .backgroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavBar()
    }
    
    override func setUpNavBar() {
        super.setUpNavBar()
        let button = UIButton()
        button.setImage(.shareIcon(), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: currentType.cells[indexPath.row].cell.cellIdn(), for: indexPath) as? DetailsCell else { return UITableViewCell()}
        cell.configure(model: viewModel.movie, genres: viewModel.genres, image: viewModel.image)
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        if let cell = cell as? SynopsisTableViewCell {
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return UITableView.automaticDimension
        }
        return currentType.cells[indexPath.row].heightForRow
    }
}

extension DetailsViewController: SynopsisDelegate {
    func reloadData() {
        self.mainView.tableView.reloadData()
    }
}

private extension DetailsViewController {
    
    @objc func share() {
        
    }
}
