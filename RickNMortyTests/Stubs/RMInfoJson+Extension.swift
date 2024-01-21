//
//  RMInfoJson+Extension.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation

@testable import RickNMorty

extension RMInfoJson {
    
    static func stub(count: Int = 3, pages: Int = 5, next: String? = "nextPageUrl", prev: String? = "previousPageUrl") -> RMInfoJson {
        return RMInfoJson(count: count, pages: pages, next: next, prev: prev)
    }
    
}
