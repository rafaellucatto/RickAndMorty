//
//  RMLocationJson+Stub.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

@testable import RickAndMortyUI

extension RMLocationJson {
    
    static func stub(name: String = "locationName", url: String = "locationUrl") -> RMLocationJson {
        return RMLocationJson(name: name, url: url)
    }
    
}
