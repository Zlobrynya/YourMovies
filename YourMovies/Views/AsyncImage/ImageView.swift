//
//  ImageView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 18.07.2021.
//

import SwiftUI

struct ImageView<P, I>: View where P: View, I: View {

    // MARK: - Private properties

    @ObservedObject private var viewModel: ImageViewModel

    // MARK: - External Dependencies

    @ViewBuilder private var placeholder: () -> P
    @ViewBuilder private var content: (
        Image) -> I

    // MARK: - Lifecycle

    init(
        url: String?,
        @ViewBuilder content: @escaping (Image) -> I,
        @ViewBuilder placeholder: @escaping () -> P,
        imageViewModelFactory: ImageViewModelFactoryProtocol = ImageViewModelFactory()
    ) {
        self.placeholder = placeholder
        self.content = content
        viewModel = imageViewModelFactory.viewModel(with: url)
    }
    
    init(
        url: String?,
        @ViewBuilder placeholder: @escaping () -> P,
        imageViewModelFactory: ImageViewModelFactoryProtocol = ImageViewModelFactory()
    ) where I == Image {
        self.placeholder = placeholder
        self.content = { $0 }
        viewModel = imageViewModelFactory.viewModel(with: url)
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
            content(Image(uiImage: image))
        } else {
            placeholder()
        }
    }
}

struct Image_Previews: PreviewProvider {

    static let url = "https://image.tmdb.org/t/p/w500/yizL4cEKsVvl17Wc1mGEIrQtM2F.jpg"

    static var previews: some View {
        ImageView(
            url: url,
            content: { $0 },
            placeholder: { ProgressView() }
        )
    }
}
