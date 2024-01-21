//
//  RMAnimationHandler.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation
import UIKit

protocol RMAnimationHandlerProtocol {
    func animate(_ function: @escaping () -> Void, completionHandler: (() -> Void)?)
}

final class RMAnimationHandler: RMAnimationHandlerProtocol {
    
    func animate(_ function: @escaping () -> Void, completionHandler: (() -> Void)?) {
        UIView.rmanimate(withDuration: 0.3) {
            function()
        } completion: { hasDoneMainFunction in
            if hasDoneMainFunction {
                completionHandler?()
            }
        }
    }
    
}
