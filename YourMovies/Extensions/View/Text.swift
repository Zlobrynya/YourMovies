//
//  Text.swift
//  Text
//
//  Created by Nikita Nikitin on 08.08.2021.
//

import SwiftUI

extension Text {
    init(_ key: LocalizedStringKey) {
        self.init(key, tableName: "Localization", bundle: .main)
    }
}
