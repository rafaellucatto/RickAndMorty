//
//  RMCharacterResultsJson+Stub.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/12/24.
//

import Foundation

@testable import RickNMorty

extension RMCharacterResultsJson {
    
    static func stub(id: Int = 2,
                     name: String = "Rick",
                     status: String = "alive",
                     species: String = "human",
                     type: String = "",
                     gender: String = "male",
                     origin: RMOriginJson = .stub(),
                     location: RMLocationJson = .stub(),
                     image: String = "image",
                     url: String = "url",
                     created: String = "2023-12-15",
                     episode: [String] = ["episode 1", "episode 2", "episode 3"],                     
                     charImageData: Data? = nil) -> RMCharacterResultsJson {
        
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
                                      episode: episode,
                                      charImageData: charImageData)
    }
    
}
