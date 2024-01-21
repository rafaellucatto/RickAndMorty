//
//  RMLocationJson+Stub.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/12/24.
//

import Foundation

@testable import RickNMorty

extension RMLocationJson {
    
    static func stub(name: String = "earth2", url: String = "earth2Url") -> RMLocationJson {
        return RMLocationJson(name: name, url: url)
    }
    
}
