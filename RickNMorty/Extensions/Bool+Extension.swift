//
//  Bool+Extension.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 1/21/24.
//

import Foundation

extension Bool {
    
    func shouldAnimate() -> Bool {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return false
        }
        return self
    }
    
}
