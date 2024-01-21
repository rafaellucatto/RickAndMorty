//
//  RMLocationViewModel.swift
//  RickAndMorty
//
//  Created by Rafael Lucatto on 6/28/23.
//

import Foundation
import UIKit

protocol RMLocationViewModelDelegate: AnyObject {
    func reloadTable()
    func startLoading()
    func stopLoading()
    func showCoverView()
    func hideCoverView()
    func setUserInteraction(to bool: Bool)
}

protocol RMLocationViewModelProtocol: NavigationBarViewModel, UICollectionViewDataSource, UICollectionViewDelegate {
    var api: RMLocationViewModelAPIProtocol { get }
    var locationResult: [RMMainLocation] { get }
    var delegate: RMLocationViewModelDelegate? { get set }
    var screenDelegate: RMLocationViewModelScreenDelegate? { get set }

    func fetchLocation(with url: String?)
    func shouldFirstFetchLocation()
}

protocol RMLocationViewModelScreenDelegate: AnyObject {
    func didTapResidents(chars: [RMCharacterResultsJson])
}

final class RMLocationViewModel: NavigationBarViewModel, RMLocationViewModelProtocol {

    var locationResult: [RMMainLocation] = []
    var hasFirstFetched: Bool = false
    
    weak var screenDelegate: RMLocationViewModelScreenDelegate?
    weak var delegate: RMLocationViewModelDelegate?
    
    let api: RMLocationViewModelAPIProtocol
    let animationHandler: RMAnimationHandlerProtocol
    let dispatchQueueHandler: RMDispatchQueueHandlerProtocol

    init(api: RMLocationViewModelAPIProtocol = RMLocationViewModelAPI(),
         animationHandler: RMAnimationHandlerProtocol = RMAnimationHandler(),
         dispatchQueueHandler: RMDispatchQueueHandlerProtocol = RMDispatchQueueHandler.handler) {
        self.animationHandler = animationHandler
        self.api = api
        self.dispatchQueueHandler = dispatchQueueHandler
        super.init(searchType: .location)
        super.getModel = { [weak self] in
            self?.fetchLocation(with: $0)
        }
    }

    func shouldFirstFetchLocation() {
        if !hasFirstFetched {
            fetchLocation(with: nil)
            hasFirstFetched = true
        }
    }
    
    func fetchLocation(with url: String?) {
        let url: String = (url?.isEmpty ?? true) ? ("\(SearchType.location.rawValue)1") : (url ?? "")
        animationHandler.animate { [weak self] in
            self?.delegate?.showCoverView()
        } completionHandler: { [weak self] in
            self?.delegate?.startLoading()
            self?.api.getLocations(from: url) { result in
                switch result {
                case .success(let locationResponse):
                    self?.dispatchQueueHandler.activate(queueType: .main, qualityOfService: nil, function: {
                        self?.controlNavBarPage(totalOfPages: locationResponse.info.pages,
                                                nextPageURL: locationResponse.info.next,
                                                previousPageURL: locationResponse.info.prev)
                        self?.locationResult.removeAll()
                        self?.locationResult.append(contentsOf: locationResponse.results)
                        self?.delegate?.reloadTable()
                        self?.delegate?.stopLoading()
                        self?.setNavBarLeftSideTitle()
                        self?.animationHandler.animate {
                            self?.delegate?.hideCoverView()
                        } completionHandler: {
                            self?.delegate?.setUserInteraction(to: true)
                        }
                    })
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    enum RMDetailCell: Int, CaseIterable {
        
        case name = 0
        case id = 1
        case dimension = 2
        case type = 3

        var getTitle: String {
            switch self {
            case .name: return "Name"
            case .id: return "Id"
            case .dimension: return "Dimension"
            case .type: return "Type"
            }
        }

        func getValue(for location: RMMainLocation) -> String {
            switch self {
            case .name: return location.name
            case .id: return location.id.description
            case .dimension: return location.dimension
            case .type: return location.type
            }
        }

        func presentDetail(controller: UIViewController?, location: RMMainLocation) {
            let cellModel: RMCellInfoDisplayViewModel.RMCellModel = .init(title: getTitle, value: getValue(for: location))
            let viewModel: RMCellInfoDisplayViewModel = .init(cellModel: cellModel)
            let infoDisplayView: RMCellInfoDisplayView = .init(viewModel: viewModel)
            let infoDisplayController: RMCellInfoDisplayViewController = .init(cellInfoDisplayView: infoDisplayView)
            infoDisplayController.modalPresentationStyle = .overFullScreen
            controller?.present(infoDisplayController, animated: false, completion: {
                viewModel.presentView()
            })
        }
        
    }
    
}

extension RMLocationViewModel: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return locationResult.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell: RMLocationCollectionTitleCell = UICollectionView.getCell(of: RMLocationCollectionTitleCell.self, for: collectionView, and: indexPath)
            cell.configure(with: locationResult[indexPath.section].name)
            return cell
        case 1:
            let cell: RMLocationCollectionGeneralInfoCell = UICollectionView.getCell(of: RMLocationCollectionGeneralInfoCell.self, for: collectionView, and: indexPath)
            let id: Int = locationResult[indexPath.section].id
            cell.configure(with: .id, value: id.description)
            return cell
        case 2:
            let cell: RMLocationCollectionGeneralInfoCell = UICollectionView.getCell(of: RMLocationCollectionGeneralInfoCell.self, for: collectionView, and: indexPath)
            let dimension: String = locationResult[indexPath.section].dimension
            cell.configure(with: .dimension, value: dimension)
            return cell
        case 3:
            let cell: RMLocationCollectionGeneralInfoCell = UICollectionView.getCell(of: RMLocationCollectionGeneralInfoCell.self, for: collectionView, and: indexPath)
            let type: String = locationResult[indexPath.section].type
            cell.configure(with: .type, value: type)
            return cell
        case 4:
            let cell: RMLocationCollectionResidentCell = UICollectionView.getCell(of: RMLocationCollectionResidentCell.self, for: collectionView, and: indexPath)
            let viewModel: RMLocationCollectionResidentCellViewModel = RMLocationCollectionResidentCellViewModel(residentCount: locationResult[indexPath.section].residents.count)
            cell.configure(with: viewModel)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension RMLocationViewModel: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        RMDetailCell.allCases.forEach { cell in
            if cell.rawValue == indexPath.row {
                cell.presentDetail(controller: self.controller, location: self.locationResult[indexPath.section])
                return
            }
        }
        if (indexPath.row == 4) && !(locationResult[indexPath.section].residents.isEmpty) {
            delegate?.setUserInteraction(to: false)
            delegate?.startLoading()
            let charUrls: [String] = locationResult[indexPath.section].residents
            let group: RMDispatchGroup = RMDispatchGroup()
            var chars: [RMCharacterResultsJson] = []
            for url in charUrls {
                group.enter()
                api.getCharacters(with: url) { result in
                    defer { group.leave() }
                    switch result {
                    case .success(let char):
                        chars.append(char)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            group.notify(queue: .global()) { [weak self] in
                let group2: RMDispatchGroup = RMDispatchGroup()
                for n in 0..<chars.count {
                    group2.enter()
                    self?.api.getImage(from: chars[n].image) { result in
                        switch result {
                        case .success(let data):
                            defer { group2.leave() }
                            chars[n].charImageData = data
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                group2.notify(queue: .main) {
                    chars.sort { $0.id < $1.id }
                    self?.delegate?.stopLoading()
                    self?.delegate?.setUserInteraction(to: true)
                    self?.screenDelegate?.didTapResidents(chars: chars)
                }
            }
        }
    }
    
}
