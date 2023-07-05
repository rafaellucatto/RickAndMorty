//
//  RMCharacterEpisodeCellViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/13/23.
//

import Foundation

protocol RMCharacterEpisodeCellViewModelProtocol {
    var episodeName: String { get }
    var title: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCellViewModel: RMCharacterEpisodeCellViewModelProtocol {

    let episodeName: String

    init(episodeName: String) {
        self.episodeName = episodeName
    }

    var title: String {
        guard let index = episodeName.firstIndex(of: "-") else { return "" }
        return (episodeName[index...]).description.replacingOccurrences(of: "-", with: "")
    }

    var episode: String {
        guard let index = episodeName.firstIndex(of: "-") else { return "" }
        return (episodeName[..<index]).description
    }
}
