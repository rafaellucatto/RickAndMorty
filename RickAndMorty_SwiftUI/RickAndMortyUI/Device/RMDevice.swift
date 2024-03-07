//
//  RMDevice.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/14/24.
//

import Foundation

final class RMDevice {
    
    static func isRunningTests() -> Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
}
