//
//  RMCharacter+Stub.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

@testable import RickAndMortyUI

extension RMCharacter {
    
    static func stub(id: Int = 2,
                     name: String = "Rick",
                     status: String = "alive",
                     species: String = "species",
                     type: String = "type",
                     gender: String = "male",
                     origin: RMOriginJson = .stub(),
                     location: RMLocationJson = .stub(),
                     image: String = "http://",
                     url: String = "",
                     created: String = "2017-11-04T19:09:56.428Z",
                     episode: [String] = ["", "", "", "", "", ""],
                     charImageData: Data? = Data()) -> RMCharacter {
        
        return RMCharacter(id: id,
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
