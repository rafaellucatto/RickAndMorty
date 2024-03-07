//
//  RMEpisodeCollectionViewModel.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/16/24.
//

import Alamofire
import Combine
import Foundation

protocol RMEpisodeCollectionViewModelProtocol: ObservableObject {
    var episodeCollection: [RMEpisode] { get }
    var episodeCount: Int { get }
    var loadingMaximumEpisodeCount: Int { get }
    var episodePercentage: String { get }
    var characterCount: Int { get }
    var loadingMaximumCharacterCount: Int { get }
    var characterPercentage: String { get }
    var imageCount: Int { get }
    var loadingMaximumImageCount: Int { get }
    var imagePercentage: String { get }
    var lastPage: Int { get }
    var navBarTitle: String { get }
    var menu: RMMenuDirection { get }
    
    func getEpisodes() async
    func didTapNextPage() async
    func didTapPreviousPage() async
    func didTapPage(with number: Int) async
}

final class RMEpisodeCollectionViewModel: RMEpisodeCollectionViewModelProtocol {
    
    @Published var episodeCollection: [RMEpisode] = []
    @Published var episodeCount: Int = 0
    @Published var loadingMaximumEpisodeCount: Int = 1
    @Published var characterCount: Int = 0
    @Published var loadingMaximumCharacterCount: Int = 1
    @Published var imageCount: Int = 0
    @Published var loadingMaximumImageCount: Int = 1
    @Published var lastPage: Int = 1
    @Published var navBarTitle: String = ""
    @Published var menu: RMMenuDirection = .onlyNext
    
    @Published var episodePercentage: String = ""
    @Published var characterPercentage: String = ""
    @Published var imagePercentage: String = ""
    
    var currentPage: Int = 1
    var nextPage: String?
    var previousPage: String?
    
    private var hasFirstFetchedEpisodeCollection: Bool = false
    
    private let api: RMEpisodeCollectionViewModelApiProtocol
    
    init(api: RMEpisodeCollectionViewModelApiProtocol = RMEpisodeCollectionViewModelApi()) {
        self.api = api
    }
    
    func getEpisodes() async {
        guard !hasFirstFetchedEpisodeCollection else { return }
        hasFirstFetchedEpisodeCollection = true
        let mainResponse: RMEpisodeMainResponse? = await api.getFirstEpisodes()
        guard let mainResponse: RMEpisodeMainResponse = mainResponse else { return }
        setLoadingScreenMaximumValues(with: mainResponse)
        await handleResults(with: mainResponse)
    }
    
    private func setLoadingScreenMaximumValues(with mainResponse: RMEpisodeMainResponse) {
        resetAllVariables()
        RMDispatchQueue.async { [weak self] in
            self?.loadingMaximumEpisodeCount = mainResponse.results.count
            var totalOfCharacters: Int = 0
            for n in 0..<mainResponse.results.count {
                totalOfCharacters += mainResponse.results[n].characters.count
            }
            self?.loadingMaximumCharacterCount = totalOfCharacters
            self?.loadingMaximumImageCount = totalOfCharacters
        }
    }
    
    private func incrementLoadingCount(of type: RMCount) {
        RMDispatchQueue.async { [weak self] in
            switch type {
            case .episode:
                self?.episodeCount += 1
                self?.episodePercentage = "\(Int((Double(self?.episodeCount ?? 0) / Double(self?.loadingMaximumEpisodeCount ?? 1) * 100.0).rounded(.up)))%"
            case .character:
                self?.characterCount += 1
                self?.characterPercentage = "\(Int((Double(self?.characterCount ?? 0) / Double(self?.loadingMaximumCharacterCount ?? 1) * 100.0).rounded(.up)))%"
            case .image:
                self?.imageCount += 1
                self?.imagePercentage = "\(Int((Double(self?.imageCount ?? 0) / Double(self?.loadingMaximumImageCount ?? 1) * 100.0).rounded(.up)))%"
            }
        }
    }
    
    private enum RMCount {
        case episode, character, image
    }
    
    func didTapNextPage() async {
        guard let nextPage: String = nextPage else { return }
        currentPage += 1
        let mainResponse: RMEpisodeMainResponse? = await api.getEpisodes(from: nextPage)
        guard let mainResponse: RMEpisodeMainResponse = mainResponse else { return }
        setLoadingScreenMaximumValues(with: mainResponse)
        await handleResults(with: mainResponse)
    }
    
    func didTapPreviousPage() async {
        guard let previousPage: String = previousPage else { return }
        currentPage -= 1
        let mainResponse: RMEpisodeMainResponse? = await api.getEpisodes(from: previousPage)
        guard let mainResponse: RMEpisodeMainResponse = mainResponse else { return }
        setLoadingScreenMaximumValues(with: mainResponse)
        await handleResults(with: mainResponse)
    }
    
    private func resetAllVariables() {
        RMDispatchQueue.async { [weak self] in
            self?.resetLoadingCounters()
            self?.episodeCollection.removeAll()
        }
    }
    
    func didTapPage(with number: Int) async {
        currentPage = number
        let mainResponse: RMEpisodeMainResponse? = await api.getEpisodes(from: RMEndpoint.episodeCollection.rawValue + number.description)
        guard let mainResponse: RMEpisodeMainResponse = mainResponse else { return }
        setLoadingScreenMaximumValues(with: mainResponse)
        await handleResults(with: mainResponse)
    }
    
    private func resetLoadingCounters() {
        episodeCount = 0
        characterCount = 0
        imageCount = 0
    }
    
    private func handleResults(with mainResponse: RMEpisodeMainResponse) async {
        var episodes: [RMEpisode] = []
        for episode in mainResponse.results {
            incrementLoadingCount(of: .episode)
            let currentEpisode: RMEpisode = await getCharacterCollection(for: episode)
            episodes.append(currentEpisode)
        }
        RMDispatchQueue.sync { [weak self] in
            self?.lastPage = mainResponse.info.pages
            self?.nextPage = !(mainResponse.info.next?.isEmpty ?? true) ? mainResponse.info.next : nil
            self?.previousPage = !(mainResponse.info.prev?.isEmpty ?? true) ? mainResponse.info.prev : nil
            self?.navBarTitle = "Episodes (\(self?.currentPage.description ?? "")/\(mainResponse.info.pages.description))"
            self?.handlePageInfo()
            self?.episodeCollection.append(contentsOf: episodes)
        }
    }
    
    private func handlePageInfo() {
        if !(nextPage?.isEmpty ?? true) && !(previousPage?.isEmpty ?? true) {
            menu = .previousAndNext
            return
        }
        if !(previousPage?.isEmpty ?? true) {
            menu = .onlyPrevious
            return
        }
        menu = .onlyNext
    }
    
    private func getCharacterCollection(for episode: RMEpisode) async -> RMEpisode {
        var episode: RMEpisode = episode
        var characters: [RMCharacter] = []
        return await withTaskGroup(of: RMCharacter?.self) { taskGroup in
            for url in episode.characters {
                taskGroup.addTask {
                    self.incrementLoadingCount(of: .character)
                    return await self.api.getCharacter(from: url)
                }
            }
            for await character in taskGroup {
                if let character: RMCharacter = character {
                    characters.append(character)
                }
            }
            for character in characters {
                taskGroup.addTask {
                    self.incrementLoadingCount(of: .image)
                    let data: Data? = await self.api.getCharacterImage(from: character.image)
                    var character: RMCharacter = character
                    if let data: Data = data {
                        character.charImageData = data
                    }
                    return character
                }
            }
            for await newCharacter in taskGroup {
                if let newCharacter: RMCharacter = newCharacter {
                    episode.listOfCharacters.append(newCharacter)
                }
            }
            episode.listOfCharacters.sort { $0.id < $1.id }
            return episode
        }
    }
    
}


// MARK: - Combine equivalent:
//
//private var cancellables: Set<AnyCancellable> = []
//
//func getEpisodes() {
//    getMainResponse()
//        //.mapError { $0 as Error }
//        .flatMap { mainResponse in
//            Publishers.MergeMany(mainResponse.results.map { self.getCharacterCollection(for: $0) })
//        }
//        .collect()
//        .receive(on: DispatchQueue.main)
//        .sink(receiveValue: { episodes in
//            self.episodeCollection.append(contentsOf: episodes)
//        })
//        .store(in: &cancellables)
//}
//
//private func getMainResponse() -> AnyPublisher<RMEpisodeMainResponse, Never> {
//    return Future { promise in
//        AF.request(RMEndpoint.episodeCollection.rawValue)
//            .publishDecodable(type: RMEpisodeMainResponse.self)
//            .value()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                if case .failure(let error) = completion {
//                    print("Error fetching main response: \(error)")
//                }
//            }, receiveValue: { mainResponse in
//                self.loadingMaximumEpisodeCount = mainResponse.results.count
//                var totalOfCharacters: Int = 0
//                for n in 0..<mainResponse.results.count {
//                    totalOfCharacters += mainResponse.results[n].characters.count
//                }
//                self.loadingMaximumCharacterCount = totalOfCharacters
//                self.loadingMaximumImageCount = totalOfCharacters
//
//                promise(.success(mainResponse))
//            })
//            .store(in: &self.cancellables)
//    }
//    .eraseToAnyPublisher()
//}
//
//private func getCharacterCollection(for episode: RMEpisode) -> AnyPublisher<RMEpisode, Never> {
//    return Future { promise in
//        var episode = episode
//        var characters: [RMCharacter] = []
//
//        let group = DispatchGroup()
//
//        for url in episode.characters {
//            group.enter()
//            self.getSingleCharacter(with: url)
//                .sink(receiveValue: { character in
//                    characters.append(character)
//                    group.leave()
//                })
//                .store(in: &self.cancellables)
//        }
//
//        group.notify(queue: .main) {
//            let characterImagePublishers = characters.map { self.setImage(for: $0) }
//
//            Publishers.MergeMany(characterImagePublishers)
//                .collect()
//                .sink(receiveValue: { newCharacters in
//                    episode.listOfCharacters.append(contentsOf: newCharacters)
//                    episode.listOfCharacters.sort { $0.id < $1.id }
//                    promise(.success(episode))
//                })
//                .store(in: &self.cancellables)
//        }
//    }
//    .eraseToAnyPublisher()
//}
//
//private func getSingleCharacter(with url: String) -> AnyPublisher<RMCharacter, Never> {
//    return Future { promise in
//        AF.request(url)
//            .validate()
//            .publishDecodable(type: RMCharacter.self)
//            .value()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                if case .failure(let error) = completion {
//                    print("Error fetching single character: \(error)")
//                }
//            }, receiveValue: { character in
//                self.loadingMinimumCharacterCount += 1
//                promise(.success(character))
//            })
//            .store(in: &self.cancellables)
//    }
//    .eraseToAnyPublisher()
//}
//
//private func setImage(for character: RMCharacter) -> AnyPublisher<RMCharacter, Never> {
//    return Future { promise in
//        AF.request(character.image)
//            .validate()
//            .responseData { response in
//                self.loadingMinimumImageCount += 1
//                var character = character
//                character.charImageData = response.value
//                promise(.success(character))
//            }
//    }
//    .eraseToAnyPublisher()
//}
