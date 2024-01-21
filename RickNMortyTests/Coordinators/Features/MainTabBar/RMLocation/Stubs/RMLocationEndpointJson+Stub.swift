//
//  RMLocationEndpointJson+Stub.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation

@testable import RickNMorty

extension RMLocationEndpointJson {
    
    static func stub(info: RMInfoJson = .stub(), results: [RMMainLocation] = [.stub()]) -> RMLocationEndpointJson {
        return RMLocationEndpointJson(info: info, results: results)
    }
    
}
