//
//  String+Extension.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/16/24.
//

import Foundation

extension String {
    
    func fixDateFormat() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date: Date = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
}
