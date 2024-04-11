//
//  CustomTableView.swift
//  Movies
//
//  Created by Jane Strashok on 11.04.2024.
//

import UIKit

class CustomTableView: UITableView {
    
    private let maxHeight = CGFloat(300)
    private let minHeight = CGFloat(100)
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
        
    override public var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        if contentSize.height < minHeight {
            return CGSize(width: contentSize.width, height: minHeight)
        }
        else {
            return contentSize
        }
    }
}
