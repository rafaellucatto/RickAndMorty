//
//  RMEpisodeCollectionViewModelApi.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

protocol RMEpisodeCollectionViewModelApiProtocol {
    func getFirstEpisodes() async -> RMEpisodeMainResponse?
    func getEpisodes(from page: String) async -> RMEpisodeMainResponse?
    func getCharacter(from url: String) async -> RMCharacter?
    func getCharacterImage(from url: String) async -> Data?
}

final class RMEpisodeCollectionViewModelApi: RMEpisodeCollectionViewModelApiProtocol {
    
    private let requestManager: RMRequestManagerProtocol?
    
    init(requestManager: RMRequestManagerProtocol? = RMRequestManager.shared) {
        self.requestManager = requestManager
    }
    
    func getFirstEpisodes() async -> RMEpisodeMainResponse? {
        return await requestManager?.request(with: RMEndpoint.episodeCollection.rawValue, for: RMEpisodeMainResponse.self)
    }

    func getEpisodes(from page: String) async -> RMEpisodeMainResponse? {
        return await requestManager?.request(with: page, for: RMEpisodeMainResponse.self)
    }
    
    func getCharacter(from url: String) async -> RMCharacter? {
        return await requestManager?.request(with: url, for: RMCharacter.self)
    }
    
    func getCharacterImage(from url: String) async -> Data? {
        return await requestManager?.requestData(with: url)
    }
    
}
