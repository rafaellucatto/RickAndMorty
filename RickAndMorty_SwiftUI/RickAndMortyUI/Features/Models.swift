//
//  Models.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/14/24.
//

import Foundation

struct RMCharacterEndpointJson: Decodable {
    let info: RMInfoJson
    let results: [RMCharacter]
}

struct RMCharacter: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: RMOriginJson
    let location: RMLocationJson
    let image: String
    let url: String
    let created: String

    var episode: [String]
    var charImageData: Data?
}

struct RMInfoJson: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct RMLocationJson: Decodable {
    let name: String
    let url: String
}

struct RMOriginJson: Decodable {
    let name: String
    let url: String
}

// MARK: - Episodes

struct RMEpisodeMainResponse: Decodable {
    let info: RMInfoJson
    let results: [RMEpisode]
}

struct RMEpisode: Decodable {

    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
    var listOfCharacters: [RMCharacter] = []

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
}

// MARK: - Locations

struct RMLocationMainResopnse: Decodable {
    let info: RMInfoJson
    let results: [RMLocation]
}

struct RMLocation: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    var listOfCharacters: [RMCharacter] = []
    
    enum CodingKeys: CodingKey {
        case id, name, type, dimension, residents, url, created
    }
}
