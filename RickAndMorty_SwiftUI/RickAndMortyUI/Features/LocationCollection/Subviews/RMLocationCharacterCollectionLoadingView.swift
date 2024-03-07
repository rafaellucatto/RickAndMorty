//
//  RMLocationCharacterCollectionLoadingView.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/19/24.
//

import SwiftUI

struct RMLocationCharacterCollectionLoadingView<ViewModel: RMLocationResidentCollectionViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ProgressView(value: Double(viewModel.loadingMinimumCharacterCount), total: Double(viewModel.loadingMaximumCharacterCount)) {
                Text("Loading characters")
            } currentValueLabel: {
                Text(viewModel.characterPercentage)
            }
            .tint(.green)
            .padding(.horizontal, 14)
            .animation(.easeOut, value: viewModel.loadingMinimumCharacterCount)
            ProgressView(value: Double(viewModel.loadingMinimumImageCount), total: Double(viewModel.loadingMaximumImageCount)) {
                Text("Loading images")
            } currentValueLabel: {
                Text(viewModel.imagePercentage)
            }
            .tint(.red)
            .padding(.horizontal, 14)
            .animation(.easeOut, value: viewModel.loadingMinimumImageCount)
        }
    }
    
}

//#Preview {
//    RMLocationCharacterCollectionLoadingView()
//}
