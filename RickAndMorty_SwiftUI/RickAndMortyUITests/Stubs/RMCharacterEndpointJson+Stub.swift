//
//  RMCharacterEndpointJson+Stub.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

@testable import RickAndMortyUI

extension RMCharacterEndpointJson {
    
    static func stub(info: RMInfoJson = .stub(), results: [RMCharacter] = Array(repeating: .stub(), count: 7)) -> RMCharacterEndpointJson {
        return RMCharacterEndpointJson(info: info, results: results)
    }
    
}
