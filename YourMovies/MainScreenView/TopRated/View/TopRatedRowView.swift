//
//  TopRatedRowView.swift
//  TopRatedRowView
//
//  Created by Nikita Nikitin on 15.08.2021.
//

import SwiftUI

struct TopRatedRowView: View {

    // MARK: - External Dependencies

    var film: FilmProtocol

    // MARK: - Body

    var body: some View {
        ImageView(
            url: film.posterPath,
            content: { image($0) },
            placeholder: { ProgressView() }
        )
    }

    // MARK: - Views

    private func image(_ image: Image) -> some View {
        image.resizable()
            .cornerRadius(8)
            .compositingGroup()
            .shadow(color: .black.opacity(0.8), radius: 2, x: 1, y: 0)
            .padding(4)
            
    }
}

struct TopRatedRowView_Previews: PreviewProvider {

    static var film = Film(
        id: 1,
        title: "The Shawshank Redemption",
        posterPath: "/blA7XAUhROE7EZKN0U7Xxq2Skze.jpg",
        backdropPath: "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg"
    )

    static var previews: some View {
        film.updatePath(withStoreImageUrl: DiContainer.endpoints.storeImage)
        return TopRatedRowView(film: film)
    }
}
