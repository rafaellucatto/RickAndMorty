//
//  RMInfoJson.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

struct RMInfoJson: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
