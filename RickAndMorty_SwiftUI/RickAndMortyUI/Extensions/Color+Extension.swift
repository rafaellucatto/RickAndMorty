//
//  Color+Extension.swift
//  RickAndMortyUI
//
//  Created by Rafael Lucatto on 2/28/24.
//

import Foundation
import SwiftUI

extension Color: RawRepresentable {

    public init?(rawValue: String) {
        guard let data: Data = Data(base64Encoded: rawValue) else {
            self = .black
            return
        }
        if let color: UIColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) {
            self = Color(uiColor: color)
        } else {
            self = .black
        }
    }

    public var rawValue: String {
        if let data: Data = try? NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data {
            return data.base64EncodedString()
        }
        return ""
    }

}
