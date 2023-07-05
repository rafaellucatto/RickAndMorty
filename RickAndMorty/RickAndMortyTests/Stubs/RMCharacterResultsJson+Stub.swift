//
//  RMCharacterResultsJson+Stub.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

@testable import RickAndMorty

extension RMCharacterResultsJson {
    static func stub(id: Int = 1,
                     name: String = "Rick",
                     status: String = "alive",
                     species: String = "human",
                     type: String = "",
                     gender: String = "male",
                     origin: RMOriginJson = .stub(),
                     location: RMLocationJson = .stub(),
                     image: String = "",
                     url: String = "",
                     created: String = "Nov/03/2020",
                     episode: [String] = ["", "", ""]) -> RMCharacterResultsJson {
        return RMCharacterResultsJson(id: id,
                                      name: name,
                                      status: status,
                                      species: species,
                                      type: type,
                                      gender: gender,
                                      origin: origin,
                                      location: location,
                                      image: image,
                                      url: url,
                                      created: created,
                                      episode: episode)
    }
}
