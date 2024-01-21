//
//  RMEpisodeResults+Extension.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation

@testable import RickNMorty

extension RMEpisodeResults {
    
    static func stub(id: Int = 3,
                     name: String = "Name",
                     airDate: String = "airDate",
                     episode: String = "episode",
                     characters: [String] = [],
                     url: String = "url",
                     created: String = "Created",
                     listOfCharacters: [RMCharacterResultsJson] = [.stub(), .stub(), .stub()]) -> RMEpisodeResults {
        
        return RMEpisodeResults(id: id,
                                name: name,
                                airDate: airDate,
                                episode: episode,
                                characters: characters,
                                url: url,
                                created: created,
                                listOfCharacters: listOfCharacters)
    }
}
