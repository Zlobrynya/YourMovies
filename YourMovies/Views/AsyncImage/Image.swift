//
//  Image.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 18.07.2021.
//

import SwiftUI

struct Image<P, I>: View where P: View, I: View {

    // MARK: - Private properties

    @ObservedObject private var viewModel: ImageViewModel

    // MARK: - External Dependencies

    @ViewBuilder private var placeholder: () -> P
    @ViewBuilder private var content: (SwiftUI.Image) -> I

    // MARK: - Lifecycle

    init(url: URL, @ViewBuilder content: @escaping (SwiftUI.Image) -> I, @ViewBuilder placeholder: @escaping () -> P) {
        self.placeholder = placeholder
        self.content = content
        viewModel = ImageViewModel(url: url)
    }

    // MARK: - Body

    var body: some View {
        Group {
            main
        }.task {
            await viewModel.fetchImage()
        }
    }

    // MARK: - Views

    @ViewBuilder
    var main: some View {
        if let image = viewModel.image {
            content(SwiftUI.Image(uiImage: image))
        } else {
            placeholder()
        }
    }
}

struct Image_Previews: PreviewProvider {

    // swiftlint:disable:next force_unwrapping
    static let url = URL(string: "test")!

    static var previews: some View {
        Text("Placeholder")
//        Image(url: url) {
//            Text("Placeholder")
//        }
    }
}
