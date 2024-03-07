//
//  RMCharacterCollectionViewModelApi.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

protocol RMCharacterCollectionViewModelApiProtocol {
    func getFirstPageCharacters() async -> RMCharacterEndpointJson?
    func getCharacters(from page: String) async -> RMCharacterEndpointJson?
}

final class RMCharacterCollectionViewModelApi: RMCharacterCollectionViewModelApiProtocol {
    
    private let requestManager: RMRequestManagerProtocol?
    
    init(requestManager: RMRequestManagerProtocol? = RMRequestManager.shared) {
        self.requestManager = requestManager
    }
    
    func getFirstPageCharacters() async -> RMCharacterEndpointJson? {
        return await requestManager?.request(with: RMEndpoint.characterCollection.rawValue, for: RMCharacterEndpointJson.self)
    }
    
    func getCharacters(from page: String) async -> RMCharacterEndpointJson? {
        return await requestManager?.request(with: page, for: RMCharacterEndpointJson.self)
    }
    
}
