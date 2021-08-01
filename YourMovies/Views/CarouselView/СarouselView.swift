//
//  СarouselView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 12.07.2021.
//

import SwiftUI

struct CarouselView<Content, T>: View where Content: View, T: Hashable {

    @ObservedObject var carouselState: CarouselState<T>
    @GestureState var offset: CGFloat = 0
    @GestureState var scaleEffect: CGFloat = 0

    @State var currentItem = 0
    @State var index = 0

    let spacing: CGFloat = -15
    let tralingSpacing: CGFloat = 60

    var action: (T) -> Content
    let array: [T]

    // MARK: - Lifecycle

    // ???
    init(array: [T], @ViewBuilder action: @escaping (T) -> Content) {
        self.action = action
        self.array = array
        carouselState = CarouselState(conent: array)
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { globalProxy in
            let width = globalProxy.size.width - tralingSpacing
            let test = currentItem != 0 ? ((tralingSpacing / 2) + CGFloat(self.currentItem) * abs(spacing)) : 0
            HStack(spacing: spacing) {
                ForEach(Array(carouselState.content.enumerated()), id: \.offset) { offset, item in
                    action(item)
                        .frame(width: width)
                        .scaleEffect(testScale(offset: offset))
                        .border(currentItem == offset ? Color.red : Color.green)
                }
            }
            .offset(x: (CGFloat(currentItem) * -width) + test + self.offset)
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

    func testScale(offset: Int) -> CGFloat {
        guard offset != currentItem else { return 1 }
        let defaultScale = 0.8
        guard offset != (currentItem - 1) || (offset != currentItem + 1) else { return defaultScale }
        let scale = defaultScale + scaleEffect
        return scale <= 0.88 ? scale : 0.88
    }
}
