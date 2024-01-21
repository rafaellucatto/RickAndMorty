//
//  AnalyticsProtocol.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/17/23.
//

import Foundation

@frozen enum EventName: String {
    case action
    case page
}

protocol AnalyticsProtocol {
    var name: EventName { get }
    var parameters: [ParameterKey: String] { get }
}

@frozen enum ParameterKey: String {
    case hash
    case pagename
    case buttonname
    case charactername
    case episodename
    case locationname
}
