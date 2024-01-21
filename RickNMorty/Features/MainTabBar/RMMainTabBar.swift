//
//  RMMainTabBar.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/10/23.
//

import Foundation
import UIKit

final class RMMainTabBarController: UITabBarController {

    private let viewModel: RMMainTabBarViewModelProtocol
    
    init(viewModel: RMMainTabBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setViewControllers(self.viewModel.getControllers(), animated: false)
        self.delegate = self
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

extension RMMainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navC: UINavigationController = viewController as? UINavigationController else { return }
        if let _: RMCharacterCollectionViewController = navC.topViewController as? RMCharacterCollectionViewController {
            AnalyticsManager.shared.logEvent(event: RMCharacterCollectionAnalytics.page)
            return
        }
        if let _: RMEpisodeCharacterCollectionViewController = navC.topViewController as? RMEpisodeCharacterCollectionViewController {
            AnalyticsManager.shared.logEvent(event: RMEpisodeCharacterCollectionAnalytics.page)
            return
        }
        if let _: RMEpisodeCharacterCollectionViewController = navC.topViewController as? RMEpisodeCharacterCollectionViewController {
            AnalyticsManager.shared.logEvent(event: RMLocationAnalytics.page)
        }
    }
    
}
