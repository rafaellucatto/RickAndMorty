//
//  RMLocationResidentCollectionViewModelApi.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 3/4/24.
//

import Foundation

protocol RMLocationResidentCollectionViewModelApiProtocol {
    func getSingleCharacter(from url: String) async -> RMCharacter?
    func getImage(for character: RMCharacter) async -> Data?
}

final class RMLocationResidentCollectionViewModelApi: RMLocationResidentCollectionViewModelApiProtocol {
    
    private let requestManager: RMRequestManagerProtocol?
    
    init(requestManager: RMRequestManagerProtocol? = RMRequestManager.shared) {
        self.requestManager = requestManager
    }
    
    func getSingleCharacter(from url: String) async -> RMCharacter? {
        return await requestManager?.request(with: url, for: RMCharacter.self)
    }
    
    func getImage(for character: RMCharacter) async -> Data? {
        return await requestManager?.requestData(with: character.image)
    }
    
}
