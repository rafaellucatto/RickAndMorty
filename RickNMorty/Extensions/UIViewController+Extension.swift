//
//  UIViewController+Extension.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 1/6/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func pushVC(_ viewController: UIViewController, animated: Bool) {
        if let navC: UINavigationController = self as? UINavigationController {
            navC.pushViewController(viewController, animated: animated.shouldAnimate())
        } else if let navC: UINavigationController = self.parent as? UINavigationController {
            navC.pushViewController(viewController, animated: animated.shouldAnimate())
        }
    }
    
}
