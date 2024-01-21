//
//  UICollectionView+Extension.swift
//  RickNMorty
//
//  Created by Rafael Lucatto on 1/11/24.
//

import Foundation
import UIKit

extension UICollectionView {
    
    static func getCell<T: UICollectionViewCell>(of type: T.Type, for collection: UICollectionView, and indexPath: IndexPath) -> T {
        collection.register(T.self, forCellWithReuseIdentifier: T.identifier)
        guard let cell: T = collection.dequeueReusableCell(withReuseIdentifier: T.identifier,
                                                           for: indexPath) as? T else {
            fatalError("Unable to dequeue cell.")
        }
        return cell
    }
    
    static func getReusableView<T: UICollectionReusableView>(of type: T.Type, for collection: UICollectionView, and indexPath: IndexPath) -> T {
        collection.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        guard let cell: T = collection.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                        withReuseIdentifier: T.identifier,
                                                                        for: indexPath) as? T else {
            fatalError("Unable to dequeue header cell.")
        }
        return cell
    }
    
}
