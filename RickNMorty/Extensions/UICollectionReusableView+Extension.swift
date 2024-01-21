//
//  UICollectionReusableView+Extension.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 11/28/23.
//

import Foundation
import UIKit

extension UICollectionReusableView {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
}
