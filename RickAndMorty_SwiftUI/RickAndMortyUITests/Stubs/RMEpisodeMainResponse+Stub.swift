//
//  RMEpisodeMainResponse+Stub.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/26/24.
//

import Foundation

@testable import RickAndMortyUI

extension RMEpisodeMainResponse {
    
    static func stub(info: RMInfoJson = .stub(), 
                     results: [RMEpisode] = Array(repeating: .stub(), count: 7)) -> RMEpisodeMainResponse {
        return RMEpisodeMainResponse(info: info, 
                                     results: results)
        
    }
    
}
