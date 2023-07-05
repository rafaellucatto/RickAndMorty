//
//  RMMainTabBar.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/10/23.
//

import Foundation
import UIKit

final class RMMainTabBarController: UITabBarController {

    private let requestManager: RMRequestManagerProtocol

    init(requestManager: RMRequestManagerProtocol = RMRequestManager.shared) {
        self.requestManager = requestManager
        super.init(nibName: nil, bundle: nil)
        setUpViewControllers()
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setUpViewControllers() {
        var vcs: [UIViewController] = []
        for _tab in RMTab.allCases {
            let vc: UIViewController = _tab.getViewController(requestManager: self.requestManager)
            vc.tabBarItem = _tab.tabBarItem
            vcs.append(vc)
        }
        setViewControllers(vcs, animated: false)
    }

    private enum RMTab: String, CaseIterable {

        case characters = "Characters"
        case episodes = "Episodes"
        case locations = "Locations"

        func getViewController(requestManager: RMRequestManagerProtocol) -> UIViewController {
            switch self {
            case .characters:
                let viewModel: RMCharacterCollectionViewModelProtocol = RMCharacterCollectionViewModel(requestManager: requestManager)
                let charView: RMCharacterCollectionView = RMCharacterCollectionView(viewModel: viewModel)
                let charVC: RMCharacterCollectionViewController = RMCharacterCollectionViewController(characterCollectionView: charView)
                let navController: UINavigationController = UINavigationController(rootViewController: charVC)
                return navController
            case .episodes:
                let viewModel: RMEpisodeCharacterCollectionViewModelProtocol = RMEpisodeCharacterCollectionViewModel(requestManager: requestManager)
                let episodeView: RMEpisodeCharacterCollectionView = RMEpisodeCharacterCollectionView(viewModel: viewModel)
                let episodeVC: RMEpisodeCharacterCollectionViewController = RMEpisodeCharacterCollectionViewController(episodeView: episodeView)
                let navC: UINavigationController = UINavigationController(rootViewController: episodeVC)
                return navC
            case .locations:
                let viewModel: RMLocationViewModelProtocol = RMLocationViewModel(requestManager: requestManager)
                let locationView: RMLocationView = RMLocationView(viewModel: viewModel)
                let locationVC: RMLocationViewController = RMLocationViewController(locationView: locationView)
                let navC: UINavigationController = UINavigationController(rootViewController: locationVC)
                return navC
            }
        }

        var tabBarItem: UITabBarItem {
            switch self {
            case .characters:
                return getTabBarItem(for: .characters)
            case .episodes:
                return getTabBarItem(for: .episodes)
            case .locations:
                return getTabBarItem(for: .locations)
            }
        }

        private func getTabBarItem(for imageSystemName: SystemImageName) -> UITabBarItem {
            return UITabBarItem(title: self.rawValue, image: UIImage(systemName: imageSystemName.rawValue), tag: imageSystemName.tag)
        }

        private enum SystemImageName: String {

            case characters = "person.3.sequence"
            case episodes = "tv"
            case locations = "globe.americas"

            var tag: Int {
                switch self {
                case .characters:
                    return 0
                case .episodes:
                    return 1
                case .locations:
                    return 2
                }
            }
        }
    }
}
