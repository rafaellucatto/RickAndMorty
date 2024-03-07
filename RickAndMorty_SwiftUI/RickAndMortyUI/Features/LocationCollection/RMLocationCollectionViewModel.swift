//
//  RMLocationCollectionViewModel.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/19/24.
//

import Foundation
import SwiftUI

protocol RMLocationCollectionViewModelProtocol: ObservableObject {
    var locations: [RMLocation] { get }
    var lastPage: Int { get }
    var navBarTitle: String { get }
    var menu: RMMenuDirection { get }
    var cardColor: Color { get set }
    func getFirstLocations() async
    func didTapNextPage() async
    func didTapPreviousPage() async
    func didTapPage(with number: Int) async
}

final class RMLocationCollectionViewModel: RMLocationCollectionViewModelProtocol {
    
    private enum RMColorSaving: String {
        case card = "cardColorUserDefaults"
    }
    
    @Published var locations: [RMLocation] = []
    @Published var lastPage: Int = 1
    @Published var menu: RMMenuDirection = .onlyNext
    @Published var navBarTitle: String = ""
    @AppStorage(RMColorSaving.card.rawValue) var cardColor: Color = Color(uiColor: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1))
    
    private var nextPage: String?
    private var previousPage: String?
    private var currentPage: Int = 1
    private var hasMadeFirstRequest: Bool = false
    
    private let api: RMLocationCollectionViewModelApiProtocol
    
    init(api: RMLocationCollectionViewModelApiProtocol = RMLocationCollectionViewModelApi()) {
        self.api = api
    }
    
    func getFirstLocations() async {
        guard !hasMadeFirstRequest else { return }
        hasMadeFirstRequest = true
        let locationMainResponse: RMLocationMainResopnse? = await api.getFirstPage()
        guard let locationMainResponse: RMLocationMainResopnse = locationMainResponse else { return }
        handleResponse(with: locationMainResponse)
    }
    
    func didTapNextPage() async {
        guard let nextPage: String = nextPage else { return }
        currentPage += 1
        let locationMainResponse: RMLocationMainResopnse? = await api.getLocations(from: nextPage)
        guard let locationMainResponse: RMLocationMainResopnse = locationMainResponse else { return }
        handleResponse(with: locationMainResponse)
    }
    
    func didTapPreviousPage() async {
        guard let previousPage: String = previousPage else { return }
        currentPage -= 1
        let locationMainResponse: RMLocationMainResopnse? = await api.getLocations(from: previousPage)
        guard let locationMainResponse: RMLocationMainResopnse = locationMainResponse else { return }
        handleResponse(with: locationMainResponse)
    }
    
    func didTapPage(with number: Int) async {
        currentPage = number
        let locationMainResponse: RMLocationMainResopnse? = await api.getLocations(from: RMEndpoint.locationCollection.rawValue + number.description)
        guard let locationMainResponse: RMLocationMainResopnse = locationMainResponse else { return }
        handleResponse(with: locationMainResponse)
    }
    
    private func handleResponse(with locationMainResponse: RMLocationMainResopnse) {
        RMDispatchQueue.async { [weak self] in
            self?.lastPage = locationMainResponse.info.pages
            self?.nextPage = !(locationMainResponse.info.next?.isEmpty ?? true) ? locationMainResponse.info.next : nil
            self?.previousPage = !(locationMainResponse.info.prev?.isEmpty ?? true) ? locationMainResponse.info.prev : nil
            self?.navBarTitle = "Locations (\(self?.currentPage.description ?? "")/\(locationMainResponse.info.pages.description))"
            self?.handlePageInfo()
            self?.locations.removeAll()
            self?.locations.append(contentsOf: locationMainResponse.results)
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
