//
//  MockRMDispatchQueueHandler.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

@testable import RickAndMorty

final class MockRMDispatchQueueHandler: RMDispatchQueueHandlerProtocol {

    var didCallActivateCount: Int = 0

    func activate(queueType: RickAndMorty.RMDispatchQueueHandler.QueueType,
                  qualityOfService: DispatchQoS.QoSClass?,
                  function: @escaping () -> Void) {
        didCallActivateCount += 1
        function()
    }
}
