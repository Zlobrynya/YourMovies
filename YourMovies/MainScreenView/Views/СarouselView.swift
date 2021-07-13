//
//  СarouselView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 12.07.2021.
//

import SwiftUI

struct CarouselView<T, Content>: View where Content: View, T: Hashable {

    @StateObject var testObject = CarouselState()
    var action: (T) -> Content
    var array: [T]

    // MARK: - Lifecycle

    init(array: [T], @ViewBuilder action: @escaping (T) -> Content) {
        self.action = action
        self.array = array
    }

    // MARK: - Body

    var body: some View {
        GeometryReader { globalProxy in
            LazyHStack(spacing: 0) {
                ForEach(Array(array.enumerated()), id: \.offset) { offset, item in
                    action(item)
                        .frame(width: (globalProxy.size.width * 0.8).rounded(), height: 250)
                        .scaleEffect(offset == testObject.currentItem ? 1 : (0.87 + testObject.scaleEffect))
                        .offset(x: testObject.offsetObject, y: 0)
                        .offset(x: testObject.movingOffset)
                        .gesture(drag(proxy: globalProxy.size.width * 0.8))
                }
            }
        }
    }

    func drag(proxy: CGFloat) -> _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture()
            .onChanged { item in
                withAnimation {
                    guard abs(item.translation.width) <= (proxy * 0.7) else { return }
                    testObject.movingOffset += item.translation.width > 0 ? 1 : -1
                    testObject.scaleEffect += 0.0005
                }
            }
            .onEnded { item in
                DispatchQueue.main.async {
                    withAnimation {
                        if item.translation.width > 0 {
                            guard (testObject.currentItem - 1) > -1 else {
                                testObject.offsetObject = 0
                                testObject.offsetObject -= testObject.movingOffset
                                return
                            }
                            testObject.currentItem -= 1
                        } else {
                            guard (testObject.currentItem + 1) < array.count else {
                                testObject.offsetObject = -(
                                    proxy * CGFloat(testObject.currentItem) + testObject.movingOffset
                                ).rounded()
                                return
                            }
                            testObject.currentItem += 1
                        }
                        testObject.offsetObject = -(proxy * CGFloat(testObject.currentItem)).rounded()
                        Log.debug(testObject.offsetObject)
                        testObject.movingOffset = 0
                        testObject.scaleEffect = 0
                    }
                }
            }
    }
}

extension String {
    var uuid: UUID { UUID() }
}

class CarouselState: ObservableObject {
    @Published var offsetObject: CGFloat = 0
    @Published var movingOffset: CGFloat = 0
    var currentItem = 0
    var scaleEffect: CGFloat = 0
}

// struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView()
//    }
// }

//            .gesture(
//                DragGesture()
//                    .onChanged { _ in }
//                    .onEnded { item in
//                        withAnimation {
//                            if item.translation.width > 0 {
//                                test.width += geoProxy.size.width * 0.8
//                            } else {
//                                test.width -= geoProxy.size.width * 0.8
//                            }
//                        }
//                    }
//            )

struct TestData {
    let id: UUID
    let path: String

    init(id: UUID = UUID(), path: String) {
        self.id = id
        self.path = path
    }
}
