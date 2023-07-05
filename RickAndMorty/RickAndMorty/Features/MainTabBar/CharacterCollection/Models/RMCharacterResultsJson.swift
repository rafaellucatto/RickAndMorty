//
//  RMCharacterResultsJson.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

struct RMCharacterResultsJson: Decodable {

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
