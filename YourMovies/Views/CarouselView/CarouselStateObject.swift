//
//  CarouselStateObject.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 14.07.2021.
//

import SwiftUI

final class CarouselState<Content: Hashable>: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var offsetObject: CGFloat = 0
    @Published var movingOffset: CGFloat = 0
    var currentItem = 0
    var scaleEffect: CGFloat = 0
    
    // MARK: - External Dependencies

    let content: [Content]

    // MARK: - Lifecycle

    init(conent: [Content]) {
        content = conent
    }

    // MARK: - Public functions

    // TODO: Should fix the bug. Video: https://drive.google.com/file/d/16CLO2lD2BdAmIvHyBcs41OumcYizFCRM/view?usp=sharing
    func onChanged(withProxy proxy: CGFloat, andDragValue value: DragGesture.Value) {
        guard abs(movingOffset) <= (proxy * 0.4) else { return }
        withAnimation {
            movingOffset += value.translation.width > 0 ? 1 : -1
            scaleEffect += 0.0005
        }
    }

    func onEnded(withProxy proxy: CGFloat, andDragValue value: DragGesture.Value) {
        defer {
            withAnimation {
                self.offsetObject = -(proxy * CGFloat(self.currentItem)).rounded()
                self.movingOffset = 0
                self.scaleEffect = 0
            }
        }

        if value.translation.width > 0 {
            guard (currentItem - 1) > -1 else { return }
            currentItem -= 1
        } else {
            guard (currentItem + 1) < content.count else { return }
            currentItem += 1
        }
    }
}
