//
//  RMMainLocation+Stub.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation

@testable import RickNMorty

extension RMMainLocation {
    
    static func stub(id: Int = 7,
                     name: String = "Location Name",
                     type: String = "Type",
                     dimension: String = "Dimension",
                     residents: [String] = ["Resident1", "Resident2"],
                     url: String = "urlHere",
                     created: String = "createdDate") -> RMMainLocation {
        
        return RMMainLocation(id: id,
                              name: name,
                              type: type,
                              dimension: dimension,
                              residents: residents,
                              url: url,
                              created: created)
    }
    
}
