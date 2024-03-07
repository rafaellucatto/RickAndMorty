//
//  RMCharacterCollectionViewModel.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/14/24.
//

import Alamofire
import Combine
import Foundation

enum RMMenuDirection {
    case previousAndNext
    case onlyNext
    case onlyPrevious
}

protocol RMCharacterCollectionViewModelProtocol: ObservableObject {
    var characters: [RMCharacter] { get }
    var navBarTitle: String { get }
    var menu: RMMenuDirection { get }
    var lastPage: Int { get }
    func getFirstCharacters() async
    func getNextCharacters() async
    func getPreviousCharacters() async
    func getCustomPage(with number: Int) async
}

final class RMCharacterCollectionViewModel: RMCharacterCollectionViewModelProtocol {
    
    @Published var characters: [RMCharacter] = []
    @Published var menu: RMMenuDirection = .onlyNext
    @Published var navBarTitle: String = ""
    @Published var lastPage: Int = 1
    
    private var nextPage: String?
    private var previousPage: String?
    private var currentPage: Int = 1
    private var hasMadeFirstRequest: Bool = false
    
    private let api: RMCharacterCollectionViewModelApiProtocol
    
    init(api: RMCharacterCollectionViewModelApiProtocol = RMCharacterCollectionViewModelApi()) {
        self.api = api
    }
    
    func getFirstCharacters() async {
        guard !hasMadeFirstRequest else { return }
        hasMadeFirstRequest = true
        let mainEndpoint: RMCharacterEndpointJson? = await api.getFirstPageCharacters()
        guard let mainEndpoint: RMCharacterEndpointJson = mainEndpoint else { return }
        handleResults(with: mainEndpoint)
    }
    
    func getNextCharacters() async {
        guard let nextPage: String = nextPage else { return }
        let mainEndpoint: RMCharacterEndpointJson? = await api.getCharacters(from: nextPage)
        guard let mainEndpoint: RMCharacterEndpointJson = mainEndpoint else { return }
        handleResults(with: mainEndpoint)
        currentPage += 1
    }
    
    func getPreviousCharacters() async {
        guard let previousPage: String = previousPage else { return }
        let mainEndpoint: RMCharacterEndpointJson? = await api.getCharacters(from: previousPage)
        guard let mainEndpoint: RMCharacterEndpointJson = mainEndpoint else { return }
        handleResults(with: mainEndpoint)
        currentPage -= 1
    }
    
    func getCustomPage(with number: Int) async {
        let mainEndpoint: RMCharacterEndpointJson? = await api.getCharacters(from: RMEndpoint.characterCollection.rawValue + number.description)
        guard let mainEndpoint: RMCharacterEndpointJson = mainEndpoint else { return }
        currentPage = number
        RMDispatchQueue.async { [weak self] in
            self?.currentPage = number
        }
        handleResults(with: mainEndpoint)
    }
    
    private func handleResults(with mainEndpoint: RMCharacterEndpointJson) {
        RMDispatchQueue.async { [weak self] in
            self?.lastPage = mainEndpoint.info.pages
            self?.nextPage = !(mainEndpoint.info.next?.isEmpty ?? true) ? mainEndpoint.info.next : nil
            self?.previousPage = !(mainEndpoint.info.prev?.isEmpty ?? true) ? mainEndpoint.info.prev : nil
            self?.navBarTitle = "Characters (\(self?.currentPage.description ?? "")/\(mainEndpoint.info.pages.description))"
            self?.handlePageInfo()
            self?.characters.removeAll()
            self?.characters = mainEndpoint.results
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
    
}
