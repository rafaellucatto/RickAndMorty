//
//  RMLocationJson+Stub.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

@testable import RickAndMorty

extension RMLocationJson {
    static func stub(name: String = "Earth", url: String = "") -> RMLocationJson {
        return RMLocationJson(name: name, url: url)
    }
}
