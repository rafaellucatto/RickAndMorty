//
//  RMLocationEndpointJson.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

struct RMLocationEndpointJson: Decodable {
    let info: RMInfoJson
    let results: [RMMainLocation]
}
