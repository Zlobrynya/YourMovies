//
//  RoundedCorner.swift
//  RoundedCorner
//
//  Created by Nikita Nikitin on 07.08.2021.
//

import SwiftUI

struct RoundedCorner: Shape {
    
    // MARK: - Public properties

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    // MARK: - Public functions
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
