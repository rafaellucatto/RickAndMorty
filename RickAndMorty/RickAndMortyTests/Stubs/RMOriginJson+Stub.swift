//
//  RMOriginJson+Stub.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

@testable import RickAndMorty

extension RMOriginJson {
    static func stub(name: String = "Earth", url: String = "") -> RMOriginJson {
        return RMOriginJson(name: name, url: url)
    }
}
