//
//  RMOriginJson+Stub.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

@testable import RickAndMortyUI

extension RMOriginJson {
    
    static func stub(name: String = "originName", url: String = "originUrl") -> RMOriginJson {
        return RMOriginJson(name: name, url: url)
    }
    
}
