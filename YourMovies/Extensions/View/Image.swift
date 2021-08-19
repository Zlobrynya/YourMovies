//
//  Image.swift
//  Image
//
//  Created by Nikita Nikitin on 19.08.2021.
//

import SwiftUI

extension Image {
    func itemSize() -> some View {
        self.resizable()
            .cornerRadius(8)
            .compositingGroup()
            .shadow(color: .black.opacity(0.8), radius: 2, x: 1, y: 0)
            .padding(4)
    }
}
