//
//  СarouselView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 12.07.2021.
//

import SwiftUI

struct CarouselView<Content, T>: View where Content: View, T: Hashable {

    @ObservedObject var carouselState: CarouselState<T>
    var action: (T) -> Content

    // MARK: - Lifecycle

    // ???
    init(array: [T], @ViewBuilder action: @escaping (T) -> Content) {
        self.action = action
        self.carouselState = CarouselState(conent: array)
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { globalProxy in
            HStack(spacing: 0) {
                ForEach(Array(carouselState.content.enumerated()), id: \.offset) { offset, item in
                    action(item)
                        .frame(width: (globalProxy.size.width * 0.8).rounded(), height: 250)
                        .scaleEffect(offset == carouselState.currentItem ? 1 : (0.87 + carouselState.scaleEffect))
                        .offset(x: carouselState.offsetObject, y: 0)
                        .offset(x: carouselState.movingOffset)
                        .gesture(drag(proxy: globalProxy.size.width * 0.8))
                }
            }
        }
    }

    func drag(proxy: CGFloat) -> _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture()
            .onChanged { carouselState.onChanged(withProxy: proxy, andDragValue: $0) }
            .onEnded { carouselState.onEnded(withProxy: proxy, andDragValue: $0) }
    }
}
