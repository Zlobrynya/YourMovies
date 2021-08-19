//
//  View.swift
//  View
//
//  Created by Nikita Nikitin on 07.08.2021.
//

import SwiftUI

extension View {
    func asAnyView() -> AnyView {
        AnyView(self)
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    func withEnvironment() -> some View {
        environmentObject(StylingProvider())
            .environmentObject(LocalizableStringProvider())
    }
}
