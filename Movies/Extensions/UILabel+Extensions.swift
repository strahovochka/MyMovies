//
//  UILable+Extensions.swift
//  Movies
//
//  Created by Jane Strashok on 02.04.2024.
//

import UIKit

extension UILabel {
    var maxNumberOfLines: Int {
        let size = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font!], context: nil).height
        let lineHeight = font.lineHeight
        return Int( ceil(textHeight/lineHeight) )
    }
}
