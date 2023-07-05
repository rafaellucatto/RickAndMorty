//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/22/23.
//

import Foundation
import UIKit

extension UIColor {
    static let detailInfoButtonColor: UIColor = UIColor(red: 0.4, green: 0.4, blue: 0.8, alpha: 1)
    static let activityIndicatorColor: UIColor = UIColor(named: "CoverScreenActivity")!
    static let locationResidentsDisabled: UIColor = .systemGray6
    static let locationBackground: UIColor = .systemGray6
}

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension UIView {
    func addShadow(radius: CGFloat = 1, width: Int = 0, height: Int = 1, opacity: Float = 1, color: CGColor = UIColor.black.cgColor) {
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
        layer.shadowColor = color
    }
    func addCornerRadius(radius: CGFloat = 8, masksToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = masksToBounds
    }
}
