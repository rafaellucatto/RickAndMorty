//
//  RMLocationCollectionCoordinator.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/9/23.
//

import Hero
import Foundation
import UIKit

final class RMLocationCollectionCoordinator: RMBaseCoordinator {
    
    var viewController: UIViewController?
    
    func start() {
        let viewModel: RMLocationViewModelProtocol = RMLocationViewModel()
        let view: RMLocationView = .init(viewModel: viewModel)
        let vc: RMLocationViewController = .init(locationView: view)
        self.viewController = UINavigationController(rootViewController: vc)
        viewModel.screenDelegate = self
        self.viewController?.isHeroEnabled = true
    }
    
}

extension RMLocationCollectionCoordinator: RMLocationViewModelScreenDelegate {
    
    func didTapResidents(chars: [RMCharacterResultsJson]) {
        var viewModel: RMCharacterCollectionFromLocationViewModelProtocol = RMCharacterCollectionFromLocationViewModel(characters: chars)
        viewModel.screenDelegate = self
        let view: RMCharacterCollectionFromLocationView = .init(viewModel: viewModel)
        let vc: RMCharacterCollectionFromLocationViewController = .init(characterCollectionView: view)
        self.viewController?.pushVC(vc, animated: true)
    }
    
}

extension RMLocationCollectionCoordinator: RMCharacterDetailScreenDelegate {
    
    func didTapCharacter(character: RMCharacterResultsJson) {
        let viewModel: RMCharacterCollectionDetailViewModelProtocol = RMCharacterCollectionDetailViewModel(character: character)
        viewModel.screenDelegate = self
        let detailView: RMCharacterCollectionDetailView = .init(viewModel: viewModel)
        let vc: RMCharacterCollectionDetailViewController = .init(characterCollectionDetailView: detailView)
        self.viewController?.pushVC(vc, animated: true)
    }
    
}

extension RMLocationCollectionCoordinator: RMCharacterCollectionDetailViewModelScreenDelegate {
    
    func didTapCharacterInfo(cellModel: RMCellInfoDisplayViewModel.RMCellModel) {
        let viewModel: RMCellInfoDisplayViewModelProtocol = RMCellInfoDisplayViewModel(cellModel: cellModel)
        let infoDisplayView: RMCellInfoDisplayView = .init(viewModel: viewModel)
        let infoDisplayController: RMCellInfoDisplayViewController = .init(cellInfoDisplayView: infoDisplayView)
        infoDisplayController.modalPresentationStyle = .overFullScreen
        self.viewController?.present(infoDisplayController, animated: false)
    }
    
}
