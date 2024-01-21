//
//  RMDispatchQueueHandler.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

protocol RMDispatchQueueHandlerProtocol {
    func activate(queueType: RMDispatchQueueHandler.QueueType, qualityOfService: DispatchQoS.QoSClass?, function: @escaping () -> Void)
}

final class RMDispatchQueueHandler: RMDispatchQueueHandlerProtocol {

    private init() {}

    static let handler: RMDispatchQueueHandler = .init()

    enum QueueType {
        case main, global
    }

    func activate(queueType: QueueType, qualityOfService: DispatchQoS.QoSClass? = nil, function: @escaping () -> Void) {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            function()
            return
        }
        switch queueType {
        case .main:
            DispatchQueue.main.async {
                function()
            }
        case .global:
            DispatchQueue.global(qos: qualityOfService ?? .default).async {
                function()
            }
        }
    }
    
}
