//
//  СarouselView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 12.07.2021.
//

import SwiftUI

struct CarouselView: View {

    let data: [TestData] = [TestData(path: "testImage2"), TestData(path: "testImage3"), TestData(path: "testImage4"),
                            TestData(path: "testImage2"), TestData(path: "testImage3"), TestData(path: "testImage4"),
                            TestData(path: "testImage2"), TestData(path: "testImage3"), TestData(path: "testImage4")]

    @StateObject var testObject = CarouselState()
    
    // MARK: - Lifecycle

    // MARK: - Body

    var body: some View {
        GeometryReader { globalProxy in
            HStack(spacing: 0) {
                ForEach(Array(data.enumerated()), id: \.element.id) { item in
                    Image(item.element.path, bundle: .main)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(item.offset == testObject.currentItem ? 1 : 0.87)
                        .offset(x: testObject.offsetObject + 25, y: 0)
                        .frame(width: globalProxy.size.width * 0.8, height: 250)
                        .gesture(
                            DragGesture()
                                .onChanged { _ in }
                                .onEnded { item in
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            if item.translation.width > 0 {
                                                testObject.offsetObject += globalProxy.size.width * 0.8
                                                testObject.currentItem -= 1
                                            } else {
                                                testObject.offsetObject -= globalProxy.size.width * 0.8
                                                testObject.currentItem += 1
                                            }
                                        }
                                    }
                                }
                        )
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

class CarouselState: ObservableObject {
    @Published var offsetObject: CGFloat = 0
    var currentItem = 0
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}

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
