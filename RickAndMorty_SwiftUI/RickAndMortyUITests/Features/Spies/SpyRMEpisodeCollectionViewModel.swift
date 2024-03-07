//
//  SpyRMEpisodeCollectionViewModel.swift
//  RickAndMortyUITests
//
//  Created by Rafael Lucatto on 2/26/24.
//

import Foundation

@testable import RickAndMortyUI

final class SpyRMEpisodeCollectionViewModel: RMEpisodeCollectionViewModelProtocol {
    
    var episodePercentage: String
    var characterPercentage: String
    var imagePercentage: String
    
    var episodeCollection: [RMEpisode] = Array(repeating: .stub(), count: 8)
    var episodeCount: Int = 2
    var loadingMaximumEpisodeCount: Int = 8
    var characterCount: Int = 5
    var loadingMaximumCharacterCount: Int = 46
    var imageCount: Int = 4
    var loadingMaximumImageCount: Int = 46
    var lastPage: Int = 3
    var navBarTitle: String = "Episodes (1/8)"
    var menu: RMMenuDirection = .onlyNext
    
    var didCallGetEpisodes: Bool = false
    var didCallDidTapNextPage: Bool = false
    var didCallDidTapPreviousPage: Bool = false
    var didCallDidTapPage: Bool = false
    
    init() {
        episodePercentage = "\(Int((Double(self.episodeCount) / Double(self.loadingMaximumEpisodeCount) * 100.0).rounded(.up)))%"
        characterPercentage = "\(Int((Double(self.characterCount) / Double(self.loadingMaximumCharacterCount) * 100.0).rounded(.up)))%"
        imagePercentage = "\(Int((Double(self.imageCount) / Double(self.loadingMaximumImageCount) * 100.0).rounded(.up)))%"
    }
    
    func getEpisodes() async {
        didCallGetEpisodes = true
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
