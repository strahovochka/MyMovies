//
//  CustomSegmentControl.swift
//  Movies
//
//  Created by Jane Strashok on 25.03.2024.
//

import UIKit

class CustomSegmentControl: UISegmentedControl {

    private var segmentInset: CGFloat = 6 {
        didSet {
            if segmentInset == 0 {
                segmentInset = 6
            }
        }
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
        //setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hex: "#2C3F5B").cgColor
        self.layer.cornerRadius = bounds.height / 2
        self.layer.masksToBounds = true
        
        if let selectedImageView = subviews[numberOfSegments] as? UIImageView {
            selectedImageView.backgroundColor = .selectorRed()
            selectedImageView.image = nil
            
            
            selectedImageView.bounds = selectedImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            selectedImageView.layer.masksToBounds = true
            selectedImageView.layer.cornerRadius = selectedImageView.bounds.height / 2
            
            selectedImageView.layer.removeAnimation(forKey: "SelectionBounds")
            
        }
    }

}
