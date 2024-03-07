//
//  SpyRMCharacterCollectionViewModelApi.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

@testable import RickAndMortyUI

final class SpyRMCharacterCollectionViewModelApi: RMCharacterCollectionViewModelApiProtocol {
    
    var didCallGetFirstPageCharacters: Bool = false
    var didCallGetCharacters: Bool = false
    
    var shouldSucceed: Bool
    
    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }
    
    func getFirstPageCharacters() async -> RMCharacterEndpointJson? {
        didCallGetFirstPageCharacters = true
        if shouldSucceed {
            return .stub()
        }
        return nil
    }
    
    func getCharacters(from page: String) async -> RMCharacterEndpointJson? {
        didCallGetCharacters = true
        if shouldSucceed {
            return .stub()
        }
        return nil
    }
    
}
