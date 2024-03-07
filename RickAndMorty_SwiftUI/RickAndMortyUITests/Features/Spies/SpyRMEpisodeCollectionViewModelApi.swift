//
//  SpyRMEpisodeCollectionViewModelApi.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/26/24.
//

import Foundation

@testable import RickAndMortyUI

final class SpyRMEpisodeCollectionViewModelApi: RMEpisodeCollectionViewModelApiProtocol {
    
    var didCallGetFirstEpisodes: Bool = false
    var didCallGetEpisodes: Bool = false
    var didCallGetCharacter: Bool = false
    var didCallGetCharacterImage: Bool = false
    
    var shouldSucceed: Bool
    
    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }
    
    func getFirstEpisodes() async -> RMEpisodeMainResponse? {
        didCallGetFirstEpisodes = true
        if shouldSucceed {
            return .stub()
        }
        return nil
    }
    
    func getEpisodes(from page: String) async -> RMEpisodeMainResponse? {
        didCallGetEpisodes = true
        if shouldSucceed {
            return .stub()
        }
        return nil
    }
    
    func getCharacter(from url: String) async -> RMCharacter? {
        didCallGetCharacter = true
        if shouldSucceed {
            return .stub()
        }
        return nil
    }
    
    func getCharacterImage(from url: String) async -> Data? {
        didCallGetCharacterImage = true
        if shouldSucceed {
            return Data()
        }
        return nil
    }
    
}
