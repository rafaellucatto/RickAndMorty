//
//  UIView+Extension.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 11/28/23.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(radius: CGFloat = 1, offset: CGSize = CGSize(width: 0, height: 1), opacity: Float = 1, color: CGColor = UIColor.black.cgColor) {
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowColor = color
    }
    
    func addCornerRadius(radius: CGFloat = 8, masksToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = masksToBounds
    }
    
    static func rmanimate(withDuration: Double, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            animations()
            completion?(true)
            return
        }
        UIView.animate(withDuration: withDuration, animations: animations, completion: completion)
    }
    
}
