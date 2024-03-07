//
//  RMLocationResidentCollectionViewModel.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/19/24.
//

import Alamofire
import Combine
import Foundation

protocol RMLocationResidentCollectionViewModelProtocol: ObservableObject {
    var characters: [RMCharacter] { get }
    var location: String { get }
    var loadingMinimumCharacterCount: Int { get }
    var loadingMaximumCharacterCount: Int { get }
    var characterPercentage: String { get }
    var loadingMinimumImageCount: Int { get }
    var loadingMaximumImageCount: Int { get }
    var imagePercentage: String { get }
    func getCharacters() async
}

final class RMLocationResidentCollectionViewModel: RMLocationResidentCollectionViewModelProtocol {
    
    @Published var characters: [RMCharacter] = []
    @Published var loadingMinimumCharacterCount: Int = 0
    @Published var loadingMaximumCharacterCount: Int
    @Published var loadingMinimumImageCount: Int = 0
    @Published var loadingMaximumImageCount: Int
    @Published var characterPercentage: String = ""
    @Published var imagePercentage: String = ""
    
    let location: String
    
    private let urls: [String]
    
    private var api: RMLocationResidentCollectionViewModelApiProtocol
    
    init(urls: [String],
         location: String,
         api: RMLocationResidentCollectionViewModelApiProtocol = RMLocationResidentCollectionViewModelApi()) {
        self.urls = urls
        self.loadingMaximumCharacterCount = urls.count
        self.loadingMaximumImageCount = urls.count
        self.location = location
        self.api = api
    }
    
    func getCharacters() async {
        guard characters.isEmpty else { return }
        var characters: [RMCharacter] = await getCharacterCollection()
        for n in 0..<characters.count {
            characters[n].charImageData = await api.getImage(for: characters[n])
            RMDispatchQueue.async { [weak self] in
                self?.loadingMinimumImageCount += 1
                self?.imagePercentage = "\(Int((Double(self?.loadingMinimumImageCount ?? 0) / Double(self?.loadingMaximumImageCount ?? 1) * 100.0).rounded(.up)))%"
            }
        }
        RMDispatchQueue.async { [weak self] in
            self?.characters.removeAll()
            self?.characters.append(contentsOf: characters)
        }
    }

    private func getCharacterCollection() async -> [RMCharacter] {
        var chars: [RMCharacter] = []
        for url in urls {
            if let char: RMCharacter = await api.getSingleCharacter(from: url) {
                chars.append(char)
                RMDispatchQueue.async { [weak self] in
                    self?.loadingMinimumCharacterCount += 1
                    self?.characterPercentage = "\(Int((Double(self?.loadingMinimumCharacterCount ?? 0) / Double(self?.loadingMaximumCharacterCount ?? 1) * 100.0).rounded(.up)))%"
                }
            }
        }
        chars.sort { $0.id < $1.id }
        return chars
    }
}

// MARK: - Combine request

//    private var cancellable: Set<AnyCancellable> = []

//    func getCharacters() {
//        guard characters.isEmpty else { return }
//        Publishers.MergeMany(urls.map { url in
//            AF.request(url)
//                .publishDecodable(type: RMCharacter.self)
//                .compactMap { return $0.value }
//                .handleEvents(receiveOutput: { _ in
//                    DispatchQueue.main.async { [weak self] in
//                        self?.loadingMinimumCharacterCount += 1
//                    }
//                })
//                .eraseToAnyPublisher()
//        })
//        .flatMap { character in
//            AF.request(character.image)
//                .publishData()
//                .compactMap { characterImageData in
//                    var character: RMCharacter = character
//                    character.charImageData = characterImageData.data
//                    DispatchQueue.main.async { [weak self] in
//                        self?.loadingMinimumImageCount += 1
//                    }
//                    return character
//                }
//                .eraseToAnyPublisher()
//        }
//        .collect()
//        .receive(on: DispatchQueue.main)
//        .sink(receiveCompletion: { completion in
//            switch completion {
//            case .finished:
//                break
//            case .failure(let error):
//                print("AM | Error from merging publishers: \(error)")
//            }
//        }, receiveValue: { characters in
//            self.characters = characters.sorted { return $0.id < $1.id }
//        })
//        .store(in: &cancellable)
//    }
