//
//  RMCharacterCollectionViewModelAPI.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Alamofire
import Foundation

protocol RMCharacterCollectionViewModelAPIProtocol {
    var alamofire: RMAlamofireManagerProtocol? { get }
    
    func requestCharacters(with url: String, completion: @escaping ((Result<RMCharacterEndpointJson, AFError>) -> Void))
    func getImageData(with url: String, completion: @escaping (Result<Data, AFError>) -> Void)
    func getCharacterEpisodes(from url: String, completion: @escaping (Result<RMEpisodeResults, AFError>) -> Void)
}

final class RMCharacterCollectionViewModelAPI: RMCharacterCollectionViewModelAPIProtocol {
    
    let alamofire: RMAlamofireManagerProtocol?
    
    init(alamofire: RMAlamofireManagerProtocol? = RMAlamofireManager.shared) {
        self.alamofire = alamofire
    }
    
    func requestCharacters(with url: String, completion: @escaping ((Result<RMCharacterEndpointJson, AFError>) -> Void)) {
        alamofire?.request(url: url, object: RMCharacterEndpointJson.self, completion: completion)
    }
    
    func getImageData(with url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        alamofire?.requestData(url: url, completion: completion)
    }
    
    func getCharacterEpisodes(from url: String, completion: @escaping (Result<RMEpisodeResults, AFError>) -> Void) {
        alamofire?.request(url: url, object: RMEpisodeResults.self, completion: completion)
    }
    
}
