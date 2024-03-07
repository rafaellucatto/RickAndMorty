//
//  RMEpisode+Stub.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/26/24.
//

import Foundation

@testable import RickAndMortyUI

extension RMEpisode {
    
    static func stub(id: Int = 2,
                     name: String = "Rick flies to another planet",
                     airDate: String = "2020/12/15",
                     episode: String = "S01E01",
                     characters: [String] = ["", "", "", ""],
                     url: String = "https://",
                     created: String = "May 27, 2021",
                     listOfCharacters: [RMCharacter] = Array(repeating: .stub(), count: 7)) -> RMEpisode {
        
        return RMEpisode(id: id,
                         name: name,
                         airDate: airDate,
                         episode: episode,
                         characters: characters,
                         url: url,
                         created: created,
                         listOfCharacters: listOfCharacters)
    }
    
}
