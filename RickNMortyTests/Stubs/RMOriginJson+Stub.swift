//
//  RMOriginJson+Stub.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/12/24.
//

import Foundation

@testable import RickNMorty

extension RMOriginJson {
    
    static func stub(name: String = "earth1", url: String = "earth1Url") -> RMOriginJson {
        return RMOriginJson(name: name, url: url)
    }
    
}
