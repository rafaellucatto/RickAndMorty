//
//  SpyRMLocationCollectionViewModel.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/25/24.
//

import Foundation
import SwiftUI

@testable import RickAndMortyUI

final class SpyRMLocationCollectionViewModel: RMLocationCollectionViewModelProtocol {
    
    var cardColor: Color = Color(uiColor: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1))
    var locations: [RMLocation] = Array(repeating: .stub(), count: 4)
    var lastPage: Int = 3
    var navBarTitle: String = "Locations (1/3)"
    var menu: RMMenuDirection = .onlyNext
    
    var didCallGetFirstLocations: Bool = false
    var didCallDidTapNextPage: Bool = false
    var didCallDidTapPreviousPage: Bool = false
    var didCallDidTapPage: Bool = false
    
    func getFirstLocations() async {
        didCallGetFirstLocations = true
    }
    
    func didTapNextPage() async {
        didCallDidTapNextPage = true
    }
    
    func didTapPreviousPage() async {
        didCallDidTapPreviousPage = true
    }
    
    func didTapPage(with number: Int) async {
        didCallDidTapPage = true
    }
    
}
