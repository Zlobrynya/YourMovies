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
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/" + film.posterPath)) { image in
                image.resizable().frame(height: 140)
            } placeholder: {
                Color.red
            }
//            AsyncImage(
//                url: URL(string: "https://image.tmdb.org/t/p/w500/" + film.posterPath),
//                content: { image in
//                    image.image?.resizable()
//                        .frame(height: 140)
//                }
//            )
//            Image("testImage", bundle: .main)
//                .resizable()
            ////                .aspectRatio(contentMode: .fill)
//                .frame(height: 140)
            Text(film.title)
        }
    }
}

struct FilmRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmRowView(film: Film(title: "title", posterPath: "/5cbGVDmRMYVzkq5cItZ7cYlDdDR.jpg"))
    }
}
