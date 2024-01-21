//
//  RMCharacterCollectionViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/10/23.
//

import Foundation
import Hero
import UIKit

protocol RMCharacterCollectionViewModelDelegate: AnyObject {
    func hideCoverScreen()
    func reloadCollection()
    func setUserInteraction(to bool: Bool)
    func showCoverScreen()
    func startLoading()
    func stopLoading()
}

protocol RMCharacterCollectionViewModelProtocol: NavigationBarViewModel, UICollectionViewDataSource, UICollectionViewDelegate {
    var api: RMCharacterCollectionViewModelAPIProtocol { get }
    var animationHandler: RMAnimationHandlerProtocol { get }
    var characters: [RMCharacterResultsJson] { get }
    var screenDelegate: RMCharacterDetailScreenDelegate? { get set }
    var delegate: RMCharacterCollectionViewModelDelegate?  { get set }
    
    func getCharacters(with url: String?)
    func deleteHeroIdOfCells(from collectionView: UICollectionView)
}

protocol RMCharacterDetailScreenDelegate: AnyObject {
    func didTapCharacter(character: RMCharacterResultsJson)
}

final class RMCharacterCollectionViewModel: NavigationBarViewModel, RMCharacterCollectionViewModelProtocol {

    weak var screenDelegate: RMCharacterDetailScreenDelegate?
    weak var delegate: RMCharacterCollectionViewModelDelegate?
    
    var characters: [RMCharacterResultsJson] = []

    let dispatchGroup: RMDispatchGroupProtocol
    let api: RMCharacterCollectionViewModelAPIProtocol
    let animationHandler: RMAnimationHandlerProtocol

    init(animationHandler: RMAnimationHandlerProtocol = RMAnimationHandler(),
         api: RMCharacterCollectionViewModelAPIProtocol = RMCharacterCollectionViewModelAPI(),
         dispatchGroup: RMDispatchGroupProtocol = RMDispatchGroup()) {
        self.animationHandler = animationHandler
        self.api = api
        self.dispatchGroup = dispatchGroup
        super.init(searchType: .character)
        super.getModel = { [weak self] in
            self?.getCharacters(with: $0)
        }
    }

    func getCharacters(with url: String?) {
        let url: String = (url?.isEmpty ?? true) ? ("\(SearchType.character.rawValue)1") : (url ?? "")
        delegate?.setUserInteraction(to: false)
        animationHandler.animate { [weak self] in
            self?.delegate?.showCoverScreen()
        } completionHandler: { [weak self] in
            self?.delegate?.startLoading()
            self?.api.requestCharacters(with: url) { [weak self] result in
                switch result {
                case .success(let charJson):
                    self?.handleChar(charJson: charJson)
                case .failure(let error):
                    print("Error from \(#function): " + error.localizedDescription)
                }
            }
        }
    }

    private func handleChar(charJson: RMCharacterEndpointJson) {
        var charJson: RMCharacterEndpointJson = charJson
        for n in 0..<charJson.results.count {
            self.dispatchGroup.enter()
            api.getImageData(with: charJson.results[n].image) { result in
                defer { self.dispatchGroup.leave() }
                switch result {
                case .success(let data):
                    charJson.results[n].charImageData = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        self.dispatchGroup.notify(qos: .unspecified, queue: .main) { [weak self] in
            guard let self else {
                return
            }
            self.characters.removeAll()
            self.controlNavBarPage(totalOfPages: charJson.info.pages,
                                   nextPageURL: charJson.info.next,
                                   previousPageURL: charJson.info.prev)
            self.characters.append(contentsOf: charJson.results)
            self.delegate?.reloadCollection()
            self.setNavBarLeftSideTitle()
            self.delegate?.stopLoading()
            self.animationHandler.animate {
                self.delegate?.hideCoverScreen()
            } completionHandler: {
                self.delegate?.setUserInteraction(to: true)
            }
        }
    }
    
    func deleteHeroIdOfCells(from collectionView: UICollectionView) {
        collectionView.visibleCells.forEach { $0.heroID = "" }
    }
    
}

extension RMCharacterCollectionViewModel: UICollectionViewDataSource {
    
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

extension RMCharacterCollectionViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.setUserInteraction(to: false)
        let dispatchGroup: DispatchGroup = .init()
        var episodeNames: [String] = []
        delegate?.startLoading()
        for url in characters[indexPath.row].episode {
            dispatchGroup.enter()
            api.getCharacterEpisodes(from: url) { result in
                defer { dispatchGroup.leave() }
                switch result {
                case .success(let episode):
                    episodeNames.append("\(episode.episode)-\(episode.name)")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self: RMCharacterCollectionViewModel = self else { return }
            var character: RMCharacterResultsJson = self.characters[indexPath.row]
            character.episode.removeAll()
            episodeNames.sort { return $0 < $1 }
            character.episode.append(contentsOf: episodeNames)
            self.delegate?.setUserInteraction(to: true)
            collectionView.cellForItem(at: indexPath)?.heroID = K.Hero.characterCollectionCellId
            screenDelegate?.didTapCharacter(character: character)
            self.delegate?.stopLoading()
        }
    }
    
}
