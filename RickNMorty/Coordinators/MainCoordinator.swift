//
//  MainCoordinator.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 11/28/23.
//

import Foundation
import UIKit

protocol RMBaseCoordinator {
    var viewController: UIViewController? { get }
    func start()
}

final class RMMainCoordinator: RMBaseCoordinator {
    
    var window: UIWindow?
    var viewController: UIViewController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let tabViewModel: RMMainTabBarViewModelProtocol = RMMainTabBarViewModel()
        self.viewController = RMMainTabBarController(viewModel: tabViewModel)
        window?.rootViewController = self.viewController
        window?.makeKeyAndVisible()
    }
    
}
