//
//  MockRMCharacterCollectionViewModelAPI.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Alamofire
import Foundation

@testable import RickNMorty

final class MockRMCharacterCollectionViewModelAPI: RMCharacterCollectionViewModelAPIProtocol {
    
    var alamofire: RickNMorty.RMAlamofireManagerProtocol? = nil
    
    let shouldSucceed: Bool
    
    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }
    
    func requestCharacters(with url: String, completion: @escaping ((Result<RickNMorty.RMCharacterEndpointJson, Alamofire.AFError>) -> Void)) {
        if shouldSucceed {
            completion(.success(.init(info: .stub(), results: [.stub(), .stub(), .stub(), .stub(), .stub(), .stub(), .stub()])))
            return
        }
        completion(.failure(.explicitlyCancelled))
    }
    
    func getImageData(with url: String, completion: @escaping (Result<Data, Alamofire.AFError>) -> Void) {
        if shouldSucceed {
            completion(.success(Data()))
            return
        }
        completion(.failure(.explicitlyCancelled))
    }
    
    func getCharacterEpisodes(from url: String, completion: @escaping (Result<RickNMorty.RMEpisodeResults, Alamofire.AFError>) -> Void) {
        if shouldSucceed {
            completion(.success(RMEpisodeResults.stub()))
            return
        }
        completion(.failure(.explicitlyCancelled))
    }
    
}
