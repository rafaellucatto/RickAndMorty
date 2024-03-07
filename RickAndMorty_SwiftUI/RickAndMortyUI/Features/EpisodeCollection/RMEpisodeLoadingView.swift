//
//  RMEpisodeLoadingView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/18/24.
//

import SwiftUI

struct RMEpisodeLoadingView<ViewModel: RMEpisodeCollectionViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ProgressView(value: Double(viewModel.episodeCount), total: Double(viewModel.loadingMaximumEpisodeCount)) {
                Text("Loading episodes")
            } currentValueLabel: {
                Text(viewModel.episodePercentage)
            }
            .tint(.blue)
            .padding(.horizontal, 14)
            ProgressView(value: Double(viewModel.characterCount), total: Double(viewModel.loadingMaximumCharacterCount)) {
                Text("Loading characters")
            } currentValueLabel: {
                Text(viewModel.characterPercentage)
            }
            .tint(.green)
            .padding(.horizontal, 14)
            ProgressView(value: Double(viewModel.imageCount), total: Double(viewModel.loadingMaximumImageCount)) {
                Text("Loading images")
            } currentValueLabel: {
                Text(viewModel.imagePercentage)
            }
            .tint(.red)
            .padding(.horizontal, 14)
        }
    }
}

#Preview {
    RMEpisodeLoadingView(viewModel: MockRMEpisodeCollectionViewModel())
}

private final class MockRMEpisodeCollectionViewModel: RMEpisodeCollectionViewModelProtocol {
    var lastPage: Int = 9
    var navBarTitle: String = "MockViewmodel"
    var menu: RMMenuDirection = .onlyNext
    var episodeCollection: [RMEpisode] = []
    var episodeCount: Int = 1
    var loadingMaximumEpisodeCount: Int = 2
    var characterCount: Int = 1
    var loadingMaximumCharacterCount: Int = 2
    var imageCount: Int = 1
    var loadingMaximumImageCount: Int = 2
    var episodePercentage: String = "12%"
    var characterPercentage: String = "21%"
    var imagePercentage: String = "34%"
    func getEpisodes() {}
    func didTapNextPage() async {}
    func didTapPreviousPage() async {}
    func didTapPage(with number: Int) async {}
}
