//
//  UIWindow+Extension.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/12/24.
//

import Foundation
import UIKit

extension UIWindow {
    
    static func makeWindowForModalPresentation(with viewController: UIViewController?) {
        UIApplication.shared.delegate?.window??.rootViewController = viewController
        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
}
