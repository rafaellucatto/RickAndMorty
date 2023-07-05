//
//  RMCharacterEndpointJson.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

struct RMCharacterEndpointJson: Decodable {
    let info: RMInfoJson
    var results: [RMCharacterResultsJson]
}
