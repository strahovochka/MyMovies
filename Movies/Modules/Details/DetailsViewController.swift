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
            return [.main, .synopsis, .castAndCrew, .photos, .videos]
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
        return view
    }()
    
    var viewModel: DetailsViewModel
    private var currentType: DetailsViewType = .detail
    
    init(object: Movies, genres: [String], image: UIImage) {
        self.viewModel = DetailsViewModel(movie: object, genres: genres, image: image)
        super.init(controllerType: .home)
        self.viewModel.delegate = self
        self.viewModel.getContent()
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
        currentType.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: currentType.cells[indexPath.row].cell.cellIdn(), for: indexPath) as? DetailsCell else { return UITableViewCell()}
        cell.configure(model: viewModel)
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        cell.delegate = self
        if let cell = cell as? MediaCell {
            cell.isPhotos = indexPath.row == 3
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        currentType.cells[indexPath.row].heightForRow
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

extension DetailsViewController: BaseViewModelDelegate, DetailsDelegate {
    func reloadData() {
        self.mainView.tableView.reloadData()
    }
    
    func showMoreToggled(start: Bool) {
        switch start {
        case true:
            self.mainView.tableView.beginUpdates()
        case false:
            self.mainView.tableView.endUpdates()
        }
        
    }
    
    func viewAll(ofType type: ViewAllOptions, scrollTo indexPath: IndexPath?) {
        viewModel.getVideosKeys { keys in
            if let cast = self.viewModel.cast, let photos = self.viewModel.photos {
                DispatchQueue.main.async {
                    self.flowDelegate?.showViewAll(cast: cast, photos: photos, videos: keys, type: type, scrollTo: indexPath)
                }
            }
        }
    }
    
    func segmentValueChanged(sender: CustomSegmentControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentType = .detail
        case 1:
            currentType = .reviews
        case 2:
            currentType = .showtime
        default:
            break
        }
        reloadData()
    }
}

private extension DetailsViewController {
    
    @objc func share() {
        
    }
}

