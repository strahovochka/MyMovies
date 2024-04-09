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
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPressRecognizer.minimumPressDuration = 1
        view.tableView.addGestureRecognizer(longPressRecognizer)
        return view
    }()
    
    private var controllerType: ViewAllOptions
    private var viewModel: ViewMoreModel
    
    init(cast: [Cast], photos: [UIImage], videos: [String], controllerType: ViewAllOptions) {
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
            return viewModel.videos.count
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
            let key = viewModel.videos[indexPath.section]
            cell.configure(videoKey: key)
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

private extension ViewMoreViewController {
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let point = sender.location(in: self.mainView.tableView)
            let indexPath = self.mainView.tableView.indexPathForRow(at: point)
            if let indexPath = indexPath, let cell = self.mainView.tableView.cellForRow(at: indexPath) as? PhotoCell {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                    cell.photoImageView.transform = CGAffineTransform(scaleX: 0.92, y: 0.94)
                } completion: { finished in
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                        cell.photoImageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.97)
                    } completion: { finished in
                        let alert = UIAlertController(title: "Save image", message: "Are you sure you want to save this image?", preferredStyle: .alert)
                        let noAction = UIAlertAction(title: "No", style: .cancel) { _ in
                            UIView.animate(withDuration: 0.3) {
                                cell.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                            }
                        }
                        let yestAction = UIAlertAction(title: "Yes", style: .default) { _ in
                            UIView.animate(withDuration: 0.3) {
                                cell.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                            }
                            UIImageWriteToSavedPhotosAlbum(cell.photoImageView.image!, self, #selector(self.image), nil)
                        }
                        alert.addAction(noAction)
                        alert.addAction(yestAction)
                        self.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    @objc func image(image: UIImage!, didFinishSavingWithError error: NSError!, contextInfo: AnyObject!) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("Image was successfully loaded")
        }
    }
}
