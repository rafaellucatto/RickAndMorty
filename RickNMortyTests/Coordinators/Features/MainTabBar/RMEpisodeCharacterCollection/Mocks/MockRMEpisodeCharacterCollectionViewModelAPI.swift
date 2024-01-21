//
//  MockRMEpisodeCharacterCollectionViewModelAPI.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Alamofire
import Foundation

@testable import RickNMorty

final class MockRMEpisodeCharacterCollectionViewModelAPI: RMEpisodeCharacterCollectionViewModelAPIProtocol {
    
    let shouldSucceed: Bool
    
    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }
    
    func getEpisodes(with url: String, completion: @escaping (Result<RickNMorty.RMEpisodeMainResponse, Alamofire.AFError>) -> Void) {
        if shouldSucceed {
            completion(.success(.stub(results: [.stub(name: "Title 1", episode: "S01E01", listOfCharacters: [.stub(), .stub(), .stub(), .stub(), .stub(), .stub()]),
                                                .stub(name: "Title 2", episode: "S01E02", listOfCharacters: [.stub(), .stub(), .stub(), .stub(), .stub()]),
                                                .stub(name: "Title 3", episode: "S01E03", listOfCharacters: [.stub()])])))
            return
        }
        completion(.failure(.explicitlyCancelled))
    }
    
    func getEpisode(with url: String, completion: @escaping (Result<RickNMorty.RMEpisodeResults, Alamofire.AFError>) -> Void) {
        if shouldSucceed {
            completion(.success(.stub()))
            return
        }
        completion(.failure(.explicitlyCancelled))
    }
    
    func getCharacters(with url: String, completion: @escaping (Result<RickNMorty.RMCharacterResultsJson, Alamofire.AFError>) -> Void) {
        if shouldSucceed {
            completion(.success(.stub()))
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
    
}
