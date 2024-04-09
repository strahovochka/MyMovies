//
//  VideoCell.swift
//  Movies
//
//  Created by Jane Strashok on 09.04.2024.
//

import UIKit
import WebKit
import SnapKit
import YouTubeiOSPlayerHelper

class VideoCell: ViewMoreCell {
    lazy var webView: WKWebView = {
        var view = WKWebView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.contentMode = .scaleAspectFill
        view.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        view.isHidden = true
        return view
    }()
    
    override func configureView() {
        super.configureView()
        contentView.addSubview(webView)
        addSubview(activityIndicator)
    }
    
    override func makeContraints() {
        webView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityIndicator.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func configure(castMember: Cast? = nil, photo: UIImage = UIImage(), videoKey: String = "") {
        if let url = URL(string: "https://www.youtube.com/embed/\(videoKey)") {
            var youtubeRequest = URLRequest(url: url)
            self.webView.load(youtubeRequest)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if webView.isLoading {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
}
