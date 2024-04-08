//
//  ViewMoreController.swift
//  Movies
//
//  Created by Jane Strashok on 08.04.2024.
//

import UIKit

final class ViewMoreViewController: BaseViewController {
    
    lazy var mainView: ViewMoreView = {
        var view = ViewMoreView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()
    
    private var controllerType: ViewAllOptions
    private var viewModel: ViewMoreModel
    
    init(cast: [Cast], photos: [UIImage], videos: ([String], [UIImage]), controllerType: ViewAllOptions) {
        self.controllerType = controllerType
        self.viewModel = ViewMoreModel(cast: cast, photos: photos, videos: videos)
        super.init(controllerType: .home)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        self.title = controllerType.title
        self.view.backgroundColor = .backgroundColor()
    }
    
}

extension ViewMoreViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch controllerType {
        case .cast:
            return viewModel.cast.count
        case .photos:
            return viewModel.photos.count
        case .videos:
            return viewModel.videos.previews.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: controllerType.cell.cellIdn(), for: indexPath) as? ViewMoreCell else { return UITableViewCell() }
        switch controllerType {
        case .cast:
            let castMember = viewModel.cast[indexPath.section]
            cell.configure(castMember: castMember)
        case .photos:
            let photo = viewModel.photos[indexPath.section]
            cell.configure(photo: photo)
        case .videos:
            let preview = viewModel.videos.previews[indexPath.section]
            let key = viewModel.videos.keys[indexPath.section]
            cell.configure(videoPreview: (key, preview))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        controllerType.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        controllerType.headerHeight
    }
}
