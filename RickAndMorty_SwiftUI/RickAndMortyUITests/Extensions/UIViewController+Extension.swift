//
//  UIViewController+Extension.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func makeWindow() {
        let window: UIWindow = UIWindow(frame: CGRect(x: 0, y: -1, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        window.rootViewController = self
        window.makeKeyAndVisible()
    }
    
}
