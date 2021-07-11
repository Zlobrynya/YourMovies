//
//  FilmRowView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 03.07.2021.
//

import SwiftUI

struct FilmRowView: View {

    let film: Film

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(film.posterPath ?? "")")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            Text(film.title).lineLimit(1)
        }
        .frame(height: 160)
    }
}

struct FilmRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmRowView(film: Film(id: 1, title: "title", posterPath: "/5cbGVDmRMYVzkq5cItZ7cYlDdDR.jpg"))
    }
}
