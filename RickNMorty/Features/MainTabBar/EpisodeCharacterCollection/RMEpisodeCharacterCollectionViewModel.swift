//
//  EpisodeCharacterCollectionViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/25/23.
//

import Foundation
import Hero
import UIKit

protocol RMEpisodeCharacterCollectionViewModelDelegate: AnyObject {
    func hideCoverScreen()
    func reloadCollection()
    func setUserInteraction(to bool: Bool)
    func showCoverScreen()
    func startLoading()
    func stopLoading()
}

protocol RMEpisodeCharacterCollectionViewModelProtocol: NavigationBarViewModel, UICollectionViewDataSource, UICollectionViewDelegate {
    var api: RMEpisodeCharacterCollectionViewModelAPIProtocol { get }
    var animationHandler: RMAnimationHandlerProtocol { get }
    var screenDelegate: RMCharacterDetailScreenDelegate? { get set }
    var delegate: RMEpisodeCharacterCollectionViewModelDelegate? { get set }
    var dispatchQueue: RMDispatchQueueHandlerProtocol { get }
    var episodeCollection: RMEpisodeMainResponse? { get }
    var gotFirstTimeData: Bool { get }
    var hasMadeFirstRequest: Bool { get set }
    
    func deleteHeroIdOfCells(from collectionView: UICollectionView)
    func fetchEpisodeList(with url: String?)
    func shouldFirstFetchEpisodes()
}

final class RMEpisodeCharacterCollectionViewModel: NavigationBarViewModel, RMEpisodeCharacterCollectionViewModelProtocol {
    
    var gotFirstTimeData: Bool = false
    var episodeCollection: RMEpisodeMainResponse?
    var hasMadeFirstRequest: Bool = false
    
    weak var screenDelegate: RMCharacterDetailScreenDelegate?
    weak var delegate: RMEpisodeCharacterCollectionViewModelDelegate?
    
    let api: RMEpisodeCharacterCollectionViewModelAPIProtocol
    let animationHandler: RMAnimationHandlerProtocol
    let dispatchQueue: RMDispatchQueueHandlerProtocol
    
    init(animationHandler: RMAnimationHandlerProtocol = RMAnimationHandler(),
         api: RMEpisodeCharacterCollectionViewModelAPIProtocol = RMEpisodeCharacterCollectionViewModelAPI(),
         dispatchQueue: RMDispatchQueueHandlerProtocol = RMDispatchQueueHandler.handler) {
        self.animationHandler = animationHandler
        self.api = api
        self.dispatchQueue = dispatchQueue
        super.init(searchType: .episode)
        super.getModel = { [weak self] in
            self?.fetchEpisodeList(with: $0)
        }
    }
    
    func fetchEpisodeList(with url: String?) {
        let url: String = (url?.isEmpty ?? true) ? ("\(SearchType.episode.rawValue)1") : (url ?? "")
        delegate?.setUserInteraction(to: false)
        animationHandler.animate {
            self.delegate?.showCoverScreen()
        } completionHandler: { [weak self] in
            guard let self: RMEpisodeCharacterCollectionViewModel = self else { return }
            self.delegate?.startLoading()
            self.api.getEpisodes(with: url) { result in
                switch result {
                case .success(var episodeCollectionResponse):
                    let dispatchGroup: RMDispatchGroup = RMDispatchGroup()
                    for n in 0..<episodeCollectionResponse.results.count {
                        dispatchGroup.enter()
                        let charUrls: [String] = episodeCollectionResponse.results[n].characters
                        self.getListOfCharacters(with: charUrls) { characterResultsJsonList in
                            defer { dispatchGroup.leave() }
                            episodeCollectionResponse.results[n].listOfCharacters.append(contentsOf: characterResultsJsonList)
                        }
                    }
                    dispatchGroup.notify(qos: .unspecified, queue: .global(qos: .default)) {
                        self.dispatchQueue.activate(queueType: .main, qualityOfService: nil) {
                            self.episodeCollection = nil
                            self.episodeCollection = episodeCollectionResponse
                            self.controlNavBarPage(totalOfPages: episodeCollectionResponse.info.pages,
                                                   nextPageURL: episodeCollectionResponse.info.next,
                                                   previousPageURL: episodeCollectionResponse.info.prev)
                            self.delegate?.stopLoading()
                            self.delegate?.reloadCollection()
                            self.setNavBarLeftSideTitle()
                            self.animationHandler.animate {
                                self.delegate?.hideCoverScreen()
                            } completionHandler: {
                                self.delegate?.setUserInteraction(to: true)
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func getListOfCharacters(with charUrls: [String], completionHandler: @escaping ([RMCharacterResultsJson]) -> Void) {
        let dispatchGroup: RMDispatchGroup = RMDispatchGroup()
        var characterList: [RMCharacterResultsJson] = []
        for url in charUrls {
            dispatchGroup.enter()
            api.getCharacters(with: url) { [weak self] result in
                switch result {
                case .success(var char):
                    self?.api.getImageData(with: char.image) { result in
                        defer { dispatchGroup.leave() }
                        switch result {
                        case .success(let data):
                            char.charImageData = data
                            characterList.append(char)
                        case .failure(let error):
                            print("Unable to get image data from request: " + error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        dispatchGroup.notify(qos: .unspecified, queue: .global()) {
            characterList.sort { return $0.id < $1.id }
            completionHandler(characterList)
        }
    }

    private func getEpisodes(for char: RMCharacterResultsJson, completionHandler: @escaping ([String]) -> Void) {
        let group: RMDispatchGroup = RMDispatchGroup()
        var episodeNames: [String] = []
        for episodeUrl in char.episode {
            group.enter()
            api.getEpisode(with: episodeUrl) { result in
                switch result {
                case .success(let episode):
                    defer { group.leave() }
                    episodeNames.append("\(episode.episode)-\(episode.name)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        group.notify(queue: .global()) {
            completionHandler(episodeNames)
        }
    }
    
    func deleteHeroIdOfCells(from collectionView: UICollectionView) {
        collectionView.visibleCells.forEach { $0.heroID = "" }
    }
    
    func shouldFirstFetchEpisodes() {
        if !hasMadeFirstRequest {
            fetchEpisodeList(with: nil)
            hasMadeFirstRequest = true
        }
    }
    
}

extension RMEpisodeCharacterCollectionViewModel: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return episodeCollection?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeCollection?.results[section].listOfCharacters.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EpisodeCharacterCollectionCell = UICollectionView.getCell(of: EpisodeCharacterCollectionCell.self, for: collectionView, and: indexPath)
        cell.imageView.image = UIImage(data: episodeCollection?.results[indexPath.section].listOfCharacters[indexPath.row].charImageData ?? Data())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let cell: EpisodeCollectionSectionHeader = UICollectionView.getReusableView(of: EpisodeCollectionSectionHeader.self, for: collectionView, and: indexPath)
            let episode: String = episodeCollection?.results[indexPath.section].episode ?? ""
            let episodeName: String = episodeCollection?.results[indexPath.section].name ?? ""
            cell.configure(with: "\(episode) - \(episodeName)")
            return cell
        }
        return UICollectionReusableView()
    }
    
}

extension RMEpisodeCharacterCollectionViewModel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.setUserInteraction(to: false)
        guard let char: RMCharacterResultsJson = episodeCollection?.results[indexPath.section].listOfCharacters[indexPath.row] else {
            delegate?.setUserInteraction(to: true)
            return
        }
        getEpisodes(for: char) { [weak self] titles in
            var titles: [String] = titles
            self?.dispatchQueue.activate(queueType: .main, qualityOfService: nil) {
                if var char: RMCharacterResultsJson = self?.episodeCollection?.results[indexPath.section].listOfCharacters[indexPath.row] {
                    char.episode.removeAll()
                    titles.sort { return $0 < $1 }
                    char.episode.append(contentsOf: titles)
                    self?.delegate?.setUserInteraction(to: true)
                    collectionView.cellForItem(at: indexPath)?.heroID = K.Hero.characterCollectionCellId
                    self?.screenDelegate?.didTapCharacter(character: char)
                }
            }
        }
    }
    
}
