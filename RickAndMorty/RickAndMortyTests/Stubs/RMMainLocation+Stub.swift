//
//  RMMainLocation+Stub.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

@testable import RickAndMorty

extension RMMainLocation {
    static func stub(id: Int = 1,
                     name: String = "Earth",
                     type: String = "Type",
                     dimension: String = "Dimension",
                     residents: [String] = ["", ""],
                     url: String = "",
                     created: String = "Nov/01/2020") -> RMMainLocation {
        return RMMainLocation(id: id,
                              name: name,
                              type: type,
                              dimension: dimension,
                              residents: residents,
                              url: url,
                              created: created)
    }
}
