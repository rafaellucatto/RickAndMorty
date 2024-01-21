//
//  RMEpisodeMainResponse.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

struct RMEpisodeMainResponse: Decodable {
    let info: RMInfoJson
    var results: [RMEpisodeResults]
}
