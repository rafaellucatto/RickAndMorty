//
//  MockRMAnimationHandler.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation

@testable import RickAndMorty

final class MockRMAnimationHandler: RMAnimationHandlerProtocol {

    var didCallAnimateCount: Int = 0

    func animate(_ function: @escaping () -> Void, completionHandler: (() -> Void)?) {
        didCallAnimateCount += 1
        function()
        completionHandler?()
    }
}
