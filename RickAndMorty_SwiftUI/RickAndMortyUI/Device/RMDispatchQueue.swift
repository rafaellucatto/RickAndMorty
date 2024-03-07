//
//  RMDispatchQueue.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation

final class RMDispatchQueue {
    
    static func async(completion: @escaping () -> Void) {
        guard !RMDevice.isRunningTests() else {
            completion()
            return
        }
        DispatchQueue.main.async {
            completion()
        }
    }
    
    static func sync(completion: @escaping () -> Void) {
        guard !RMDevice.isRunningTests() else {
            completion()
            return
        }
        DispatchQueue.main.sync {
            completion()
        }
    }
    
}
