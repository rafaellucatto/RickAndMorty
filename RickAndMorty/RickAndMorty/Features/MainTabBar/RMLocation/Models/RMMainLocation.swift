//
//  RMMainLocation.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

struct RMMainLocation: Decodable {

    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String

}
