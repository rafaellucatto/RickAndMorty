//
//  RMCharacterCollectionFromLocationViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import Hero
import UIKit

protocol RMCharacterCollectionFromLocationViewModelDelegate: AnyObject {
    func reloadCollection()
    func startLoading()
    func stopLoading()
    func setUserInteraction(to bool: Bool)
}

protocol RMCharacterCollectionFromLocationViewModelProtocol: UICollectionViewDataSource, UICollectionViewDelegate {
    var alamofire: RMAlamofireManagerProtocol? { get }
    var controller: UIViewController? { get set }
    var delegate: RMCharacterCollectionFromLocationViewModelDelegate? { get set }
    var screenDelegate: RMCharacterDetailScreenDelegate? { get set }
    var characters: [RMCharacterResultsJson] { get }
    
    func deleteHeroIdOfCells(from collectionView: UICollectionView)
}

final class RMCharacterCollectionFromLocationViewModel: NSObject, RMCharacterCollectionFromLocationViewModelProtocol {

    weak var controller: UIViewController?
    weak var delegate: RMCharacterCollectionFromLocationViewModelDelegate?
    weak var screenDelegate: RMCharacterDetailScreenDelegate?
    
    var characters: [RMCharacterResultsJson]

    let alamofire: RMAlamofireManagerProtocol?
    
    init(alamofire: RMAlamofireManagerProtocol? = RMAlamofireManager.shared, characters: [RMCharacterResultsJson]) {
        self.alamofire = alamofire
        self.characters = characters
        super.init()
    }

    private func handleMainQueueEvent(episodeNames: [String], row: Int) {
        var episodeNames: [String] = episodeNames
        var character: RMCharacterResultsJson = self.characters[row]
        character.episode.removeAll()
        episodeNames.sort { return $0 < $1 }
        character.episode.append(contentsOf: episodeNames)
        self.delegate?.stopLoading()
        self.delegate?.setUserInteraction(to: true)
        screenDelegate?.didTapCharacter(character: character)
    }
    
    func deleteHeroIdOfCells(from collectionView: UICollectionView) {
        collectionView.visibleCells.forEach { $0.heroID = "" }
    }
    
}

extension RMCharacterCollectionFromLocationViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RMCharacterCollectionCell = UICollectionView.getCell(of: RMCharacterCollectionCell.self, for: collectionView, and: indexPath)
        let imageData: Data? = characters[indexPath.row].charImageData
        cell.configure(with: imageData)
        return cell
    }
    
}

extension RMCharacterCollectionFromLocationViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.setUserInteraction(to: false)
        let dispatchGroup: DispatchGroup = DispatchGroup()
        var episodeNames: [String] = []
        delegate?.startLoading()
        for url in characters[indexPath.row].episode {
            dispatchGroup.enter()
            alamofire?.request(url: url, object: RMEpisodeResults.self) { result in
                defer { dispatchGroup.leave() }
                switch result {
                case .success(let episode):
                    episodeNames.append("\(episode.episode)-\(episode.name)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            collectionView.cellForItem(at: indexPath)?.heroID = K.Hero.characterCollectionCellId
            self?.handleMainQueueEvent(episodeNames: episodeNames, row: indexPath.row)
        }
    }
    
}
