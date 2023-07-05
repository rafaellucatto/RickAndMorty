//
//  MockRMLocationViewModel.swift
//  RickAndMortyTests
//
//  Created by Rafael Lucatto on 7/4/23.
//

import Foundation
import UIKit

@testable import RickAndMorty

final class MockRMLocationViewModel: NavigationBarViewModel, RMLocationViewModelProtocol {

    var locationResult: [RickAndMorty.RMMainLocation] = []
    var delegate: RickAndMorty.RMLocationViewModelDelegate?

    let requestManager: RickAndMorty.RMRequestManagerProtocol

    init(requestManager: RickAndMorty.RMRequestManagerProtocol) {
        self.requestManager = requestManager
        super.init(searchType: .location)
    }

    func fetchLocation(with url: String?) {
        requestManager.request(url: "",
                               httpMethod: .get,
                               object: RickAndMorty.RMLocationEndpointJson.self) { result in
            switch result {
            case .success(let locationResponse):
                self.controlNavBarPage(totalOfPages: locationResponse.info.pages,
                                        nextPageURL: locationResponse.info.next,
                                        previousPageURL: locationResponse.info.prev)
                self.locationResult.removeAll()
                self.locationResult.append(contentsOf: locationResponse.results)
                self.delegate?.reloadTable()
                self.delegate?.stopLoading()
                self.delegate?.hideCoverView()
                self.setNavBarLeftSideTitle()
                self.delegate?.setUserInteraction(to: true)
            case .failure(let error):
                print("Error from \(#function): \(error.localizedDescription)")
            }
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return locationResult.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell: RMLocationCollectionTitleCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMLocationCollectionTitleCell.identifier,
                                                                                               for: indexPath) as? RMLocationCollectionTitleCell else {
                return UICollectionViewCell(frame: .zero)
            }
            cell.configure(with: locationResult[indexPath.section].name)
            return cell
        case 1:
            guard let cell: RMLocationCollectionGeneralInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMLocationCollectionGeneralInfoCell.identifier,
                                                                                                     for: indexPath) as? RMLocationCollectionGeneralInfoCell else {
                return UICollectionViewCell(frame: .zero)
            }
            let id = locationResult[indexPath.section].id
            cell.configure(with: .id, value: id.description)
            return cell
        case 2:
            guard let cell: RMLocationCollectionGeneralInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMLocationCollectionGeneralInfoCell.identifier,
                                                                                                     for: indexPath) as? RMLocationCollectionGeneralInfoCell else {
                return UICollectionViewCell(frame: .zero)
            }
            let dimension = locationResult[indexPath.section].dimension
            cell.configure(with: .dimension, value: dimension)
            return cell
        case 3:
            guard let cell: RMLocationCollectionGeneralInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMLocationCollectionGeneralInfoCell.identifier,
                                                                                                     for: indexPath) as? RMLocationCollectionGeneralInfoCell else {
                return UICollectionViewCell(frame: .zero)
            }
            let type = locationResult[indexPath.section].type
            cell.configure(with: .type, value: type)
            return cell
        case 4:
            guard let cell: RMLocationCollectionResidentCell = collectionView.dequeueReusableCell(withReuseIdentifier: RMLocationCollectionResidentCell.identifier,
                                                                                                  for: indexPath) as? RMLocationCollectionResidentCell else {
                return UICollectionViewCell(frame: .zero)
            }
            let viewModel: RMLocationCollectionResidentCellViewModel = RMLocationCollectionResidentCellViewModel(residentCount: locationResult[indexPath.section].residents.count)
            cell.configure(with: viewModel)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
