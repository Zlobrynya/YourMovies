//
//  СarouselView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 12.07.2021.
//

import SwiftUI

struct CarouselView<Content, T>: View where Content: View {

    // MARK: - Private properties

    @GestureState private var offset: CGFloat = 0
    @GestureState private var scaleEffect: CGFloat = 0
    @State private var currentItem = 0
    @State private var index = 0

    // MARK: - External Dependencies

    private let spacing: CGFloat
    private let tralingSpacing: CGFloat
    private var action: (T) -> Content
    private let array: [T]

    // MARK: - Lifecycle

    init(
        array: [T],
        tralingSpacing: CGFloat = 30,
        spacing: CGFloat = -15,
        @ViewBuilder action: @escaping (T) -> Content
    ) {
        self.action = action
        self.array = array
        self.spacing = spacing
        self.tralingSpacing = tralingSpacing
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { globalProxy in
            // TODO: Should hide in a separate class
            let width = globalProxy.size.width - tralingSpacing
            let additionalOffset = currentItem != 0 ? ((tralingSpacing / 2) + CGFloat(self.currentItem) * abs(spacing)) : 0
            HStack(spacing: spacing) {
                ForEach(Array(array.enumerated()), id: \.offset) { offset, item in
                    action(item)
                        .frame(width: width)
                        .scaleEffect(scale(for: offset))
                }
            }
            .frame(width: globalProxy.size.width, height: globalProxy.size.height, alignment: .leading)
            .offset(x: (CGFloat(currentItem) * -width) + additionalOffset + self.offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        guard
                            !(currentItem == 0 && value.translation.width > (globalProxy.size.width * 0.1)),
                            !(currentItem == array.count - 1 && value.translation.width < (globalProxy.size.width * 0.2))
                        else { return }
                        out = value.translation.width
                    })
                    .updating($scaleEffect, body: { value, out, _ in
                        guard
                            !(currentItem == 0 && value.translation.width > (globalProxy.size.width * 0.1)),
                            !(currentItem == array.count - 1 && value.translation.width < (globalProxy.size.width * 0.2))
                        else { return }
                        out += 0.0008
                    })
                    .onEnded { _ in
                        self.currentItem = index
                    }
                    .onChanged { value in
                        guard abs(value.translation.width) >= (globalProxy.size.width * 0.6) else { return }
                        let position = Int(round(-value.translation.width / width))
                        self.index = max(min(self.currentItem + position, array.count - 1), 0)
                    }
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }

    func scale(for offset: Int) -> CGFloat {
        guard offset != currentItem else { return 1 }
        let defaultScale = 0.8
        guard offset != (currentItem - 1) || (offset != currentItem + 1) else { return defaultScale }
        let scale = defaultScale + scaleEffect
        return scale <= 0.88 ? scale : 0.88
    }
}
