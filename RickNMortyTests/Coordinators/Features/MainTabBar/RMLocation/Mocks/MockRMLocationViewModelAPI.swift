//
//  MockRMLocationViewModelAPI.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Alamofire
import Foundation

@testable import RickNMorty

final class MockRMLocationViewModelAPI: RMLocationViewModelAPIProtocol {
    
    let shouldSucceed: Bool
    
    init(shouldSucceed: Bool = true) {
        self.shouldSucceed = shouldSucceed
    }
    
    func getLocations(from url: String, completion: @escaping (Result<RickNMorty.RMLocationEndpointJson, Alamofire.AFError>) -> Void) {
        if shouldSucceed {
            completion(.success(.stub(results: [.stub(), .stub(), .stub(), .stub()])))
        }
        completion(.failure(.explicitlyCancelled))
    }
    
    func getCharacters(with url: String, completion: @escaping (Result<RickNMorty.RMCharacterResultsJson, Alamofire.AFError>) -> Void) {
        if shouldSucceed {
            completion(.success(.stub()))
        }
        completion(.failure(.explicitlyCancelled))
    }
    
    func getImage(from url: String, completion: @escaping (Result<Data, Alamofire.AFError>) -> Void) {
        if shouldSucceed {
            completion(.success(Data()))
        }
        completion(.failure(.explicitlyCancelled))
    }
    
}
