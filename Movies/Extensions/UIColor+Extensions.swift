//
//  UIColor+Extensions.swift
//  Movies
//
//  Created by Jane Strashok on 25.03.2024.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let i = 0
        let b = 2
        if i < b {
            var _ = i + b
        }
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func backgroundColor() -> UIColor {
        UIColor(hex: "0F1B2B")
    }
    
    class func selectorRed() -> UIColor {
        UIColor(hex: "D9251D")
    }
    
    class func unselectedText() -> UIColor {
        .white.withAlphaComponent(0.5)
    }
    
    class func searchBackground() -> UIColor {
        UIColor(hex: "2B3543")
    }
}
