//
//  RMLocationAnalytics.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/17/23.
//

import Foundation

enum RMLocationAnalytics: AnalyticsProtocol {
    
    case page
    case location(name: String)
    
    var name: EventName {
        switch self {
        case .page:
            return .page
        default:
            return .action
        }
    }
    
    var parameters: [ParameterKey: String] {
        switch self {
        case .page:
            return [.hash: "p-001.000.000.001.003", .pagename: "location-collection"]
        case .location(let name):
            return [.locationname: name]
        }
    }
    
}
