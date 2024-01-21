//
//  RMCellModel+Stub.swift
//  RickNMortyTests
//
//  Created by Rafael Lucatto on 1/12/24.
//

import Foundation

@testable import RickNMorty

extension RMCellInfoDisplayViewModel.RMCellModel {
    
    static func stub(title: String = "Model Title", value: String = "Model Value") -> RMCellInfoDisplayViewModel.RMCellModel {
        return RMCellInfoDisplayViewModel.RMCellModel(title: title, value: value)
    }
    
}
