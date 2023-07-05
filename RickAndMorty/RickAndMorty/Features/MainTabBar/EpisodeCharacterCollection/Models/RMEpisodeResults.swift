//
//  RMEpisodeResults.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

struct RMEpisodeResults: Decodable {

    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    var listOfCharacters: [RMCharacterResultsJson] = []

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}
