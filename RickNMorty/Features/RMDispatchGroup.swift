//
//  RMDispatchGroup.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 1/13/24.
//

import Foundation

protocol RMDispatchGroupProtocol {
    func enter()
    func leave()
    func notify(qos: DispatchQoS, queue: DispatchQueue, execute: @escaping () -> Void)
}

final class RMDispatchGroup: RMDispatchGroupProtocol {
    
    private let group: DispatchGroup = .init()
    
    func enter() {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            group.enter()
        }
    }
    
    func leave() {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            group.leave()
        }
    }
    
    func notify(qos: DispatchQoS = .unspecified, queue: DispatchQueue, execute: @escaping () -> Void) {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            execute()
        } else {
            group.notify(qos: qos, queue: queue, execute: execute)
        }
    }
    
}
