//
//  RMMainTabBarViewModel.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/5/23.
//

import Foundation
import UIKit

protocol RMMainTabBarViewModelProtocol {
    var coordinators: [RMBaseCoordinator] { get }
    func getControllers() -> [UIViewController]
}

final class RMMainTabBarViewModel: RMMainTabBarViewModelProtocol {
    
    var coordinators: [RMBaseCoordinator] = []
    
    func getControllers() -> [UIViewController] {
        var vcs: [UIViewController] = []
        for tab in RMTab.allCases {
            let coordinator: RMBaseCoordinator = tab.getCoordinator(for: tab)
            coordinators.append(coordinator)
            guard let controller: UIViewController = coordinator.viewController else { return [] }
            vcs.append(controller)
        }
        return vcs
    }
    
}

enum RMTab: CaseIterable {

    case characters
    case episodes
    case locations

    func getCoordinator(for tab: RMTab) -> RMBaseCoordinator {
        switch tab {
        case .characters:
            let coordinator: RMCharacterCollectionCoordinator = .init()
            coordinator.start()
            getTitleAndTabBarItem(for: coordinator.viewController, with: .characters)
            return coordinator
        case .episodes:
            let coordinator: RMEpisodeCharacterCollectionCoordinator = .init()
            coordinator.start()
            getTitleAndTabBarItem(for: coordinator.viewController, with: .episodes)
            return coordinator
        case .locations:
            let coordinator: RMLocationCollectionCoordinator = .init()
            coordinator.start()
            getTitleAndTabBarItem(for: coordinator.viewController, with: .locations)
            return coordinator
        }
    }
    
    private func getTitleAndTabBarItem(for vc: UIViewController?, with tab: RMTab) {
        guard let vc: UIViewController = vc else { return }
        switch tab {
        case .characters:
            vc.tabBarItem = getTabBarItem(for: .characters)
        case .episodes:
            vc.tabBarItem = getTabBarItem(for: .episodes)
        case .locations:
            vc.tabBarItem = getTabBarItem(for: .locations)
        }
    }
    
    private var title: String {
        switch self {
        case .characters:
            return K.Title.characters
        case .episodes:
            return K.Title.episodes
        case .locations:
            return K.Title.locations
        }
    }
    
    private func getTabBarItem(for imageSystemName: ImageSystemName) -> UITabBarItem {
        return UITabBarItem(title: self.title, image: UIImage(systemName: imageSystemName.rawValue), tag: imageSystemName.tag)
    }

    private enum ImageSystemName: String {

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
