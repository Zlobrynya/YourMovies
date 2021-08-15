//
//  TrendingRowView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import SwiftUI

struct TrendingRowView: View {

    // MARK: - External Dependencies

    let film: Film

    // MARK: - Body

    var body: some View {
        image
            .shadow(color: .black.opacity(0.40), radius: 8, x: 1, y: 1)
            .overlay(title)
    }

    // MARK: - Views

    private var image: some View {
        ImageView(
            url: film.backdropPath,
            content: { $0.resizable().aspectRatio(contentMode: .fit) },
            placeholder: { ProgressView() }
        )
        .cornerRadius(20)
    }

    private var title: some View {
        VStack {
            Spacer()
            HStack {
                Text(film.title)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.black.opacity(0.60))
                    .cornerRadius(20)
                Spacer()
            }
            .font(.system(size: 12))
            .padding(8)
        }
    }
}

struct TopRateRowView_Previews: PreviewProvider {

    static let film = Film(
        id: 1,
        title: "The Shawshank Redemption",
        posterPath: "posterUrl",
        backdropPath: "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg"
    )

    static var previews: some View {
        VStack {
            TrendingRowView(film: film).padding()
        }
    }
}
