//
//  AnalyticsManager.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 12/17/23.
//

import FirebaseAnalytics
import Foundation

final class AnalyticsManager {

    private init() {}
    
    static let shared: AnalyticsManager = .init()
    
    func logEvent(event: AnalyticsProtocol) {
        Analytics.logEvent(event.name.rawValue, parameters: getDictionary(for: event.parameters))
    }
    
    private func getDictionary(for parameters: [ParameterKey: String]) -> [String: String] {
        var newDict: [String: String] = [:]
        for (key, value) in parameters {
            newDict[key.rawValue] = value
        }
        return newDict
    }
    
}
