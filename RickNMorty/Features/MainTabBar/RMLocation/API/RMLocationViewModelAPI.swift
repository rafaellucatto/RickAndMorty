//
//  RMLocationViewModelAPI.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Alamofire
import Foundation

protocol RMLocationViewModelAPIProtocol {
    func getLocations(from url: String, completion: @escaping (Result<RMLocationEndpointJson, AFError>) -> Void)
    func getCharacters(with url: String, completion: @escaping (Result<RMCharacterResultsJson, AFError>) -> Void)
    func getImage(from url: String, completion: @escaping (Result<Data, AFError>) -> Void)
}

final class RMLocationViewModelAPI: RMLocationViewModelAPIProtocol {
    
    let alamofire: RMAlamofireManagerProtocol?
    
    init(alamofire: RMAlamofireManagerProtocol? = RMAlamofireManager.shared) {
        self.alamofire = alamofire
    }
    
    func getLocations(from url: String, completion: @escaping (Result<RMLocationEndpointJson, AFError>) -> Void) {
        alamofire?.request(url: url, object: RMLocationEndpointJson.self, completion: completion)
    }
    
    func getCharacters(with url: String, completion: @escaping (Result<RMCharacterResultsJson, AFError>) -> Void) {
        alamofire?.request(url: url, object: RMCharacterResultsJson.self, completion: completion)
    }
    
    func getImage(from url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        alamofire?.requestData(url: url, completion: completion)
    }
    
}
