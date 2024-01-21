//
//  RMEpisodeCharacterCollectionViewModelAPI.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Alamofire
import Foundation

protocol RMEpisodeCharacterCollectionViewModelAPIProtocol {
    func getEpisodes(with url: String, completion: @escaping (Result<RMEpisodeMainResponse, AFError>) -> Void)
    func getEpisode(with url: String, completion: @escaping (Result<RMEpisodeResults, AFError>) -> Void)
    func getCharacters(with url: String, completion: @escaping (Result<RMCharacterResultsJson, AFError>) -> Void)
    func getImageData(with url: String, completion: @escaping (Result<Data, AFError>) -> Void)
}

final class RMEpisodeCharacterCollectionViewModelAPI: RMEpisodeCharacterCollectionViewModelAPIProtocol {
    
    private let alamofire: RMAlamofireManagerProtocol?
    
    init(alamofire: RMAlamofireManagerProtocol? = RMAlamofireManager.shared) {
        self.alamofire = alamofire
    }
    
    func getEpisodes(with url: String, completion: @escaping (Result<RMEpisodeMainResponse, AFError>) -> Void) {
        alamofire?.request(url: url, object: RMEpisodeMainResponse.self, completion: completion)
    }
    
    func getEpisode(with url: String, completion: @escaping (Result<RMEpisodeResults, AFError>) -> Void) {
        alamofire?.request(url: url, object: RMEpisodeResults.self, completion: completion)
    }
    
    func getCharacters(with url: String, completion: @escaping (Result<RMCharacterResultsJson, AFError>) -> Void) {
        alamofire?.request(url: url, object: RMCharacterResultsJson.self, completion: completion)
    }
    
    func getImageData(with url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        alamofire?.requestData(url: url, completion: completion)
    }
    
}
