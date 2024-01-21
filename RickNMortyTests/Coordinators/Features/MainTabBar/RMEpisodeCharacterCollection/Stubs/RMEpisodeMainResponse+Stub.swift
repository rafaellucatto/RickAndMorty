//
//  RMEpisodeMainResponse+Stub.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation

@testable import RickNMorty

extension RMEpisodeMainResponse {
    
    static func stub(info: RMInfoJson = .stub(), results: [RMEpisodeResults] = [.stub()]) -> RMEpisodeMainResponse {
        return RMEpisodeMainResponse(info: info, results: results)
    }
    
}
