//
//  RMLocationCollectionViewModelApi.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

protocol RMLocationCollectionViewModelApiProtocol {
    func getFirstPage() async -> RMLocationMainResopnse?
    func getLocations(from page: String) async -> RMLocationMainResopnse?
}

final class RMLocationCollectionViewModelApi: RMLocationCollectionViewModelApiProtocol {
    
    private let requestManager: RMRequestManagerProtocol?
    
    init(requestManager: RMRequestManagerProtocol? = RMRequestManager.shared) {
        self.requestManager = requestManager
    }
    
    func getFirstPage() async -> RMLocationMainResopnse? {
        return await requestManager?.request(with: RMEndpoint.locationCollection.rawValue, for: RMLocationMainResopnse.self)
    }
    
    func getLocations(from page: String) async -> RMLocationMainResopnse? {
        return await requestManager?.request(with: page, for: RMLocationMainResopnse.self)
    }
    
}
