//
//  TopRateRowView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import SwiftUI

struct TopRateRowView: View {

    // MARK: - External Dependencies

    let film: Film

    // MARK: - Body

    var body: some View {
        image.overlay(title)
    }

    // MARK: - Views

    var image: some View {
        // swiftlint:disable force_unwrapping
        Image(
            url: URL(string: "https://image.tmdb.org/t/p/w500/\(film.backdropPath ?? "")")!,
            content: { $0.resizable().aspectRatio(contentMode: .fit) },
            placeholder: { ProgressView() }
        )
        .cornerRadius(20)
    }

    var title: some View {
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
            TopRateRowView(film: film)
                .padding()
        }
    }
}
