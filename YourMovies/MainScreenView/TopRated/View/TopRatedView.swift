//
//  TopRatedView.swift
//  TopRatedView
//
//  Created by Nikita Nikitin on 15.08.2021.
//

import SwiftUI

struct TopRatedView: View {

    // MARK: - External Dependencies

    var films: [FilmProtocol]

    // MARK: - Body

    var body: some View {
        BaseRow(
            title: .topRatedMovies,
            spacing: 8,
            titleView: { $0.padding([.horizontal], 12) },
            content: { filmsView }
        )
    }

    // MARK: - Private properties

    private var filmsView: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(films, id: \.id) { film in
                        TopRatedRowView(film: film)
                            .frame(width: proxy.size.width / 3, height: proxy.size.height)
                    }
                }.padding([.horizontal], 12)
            }
        }.frame(height: UIScreen.main.bounds.height / 5)
    }
}

struct TopReatedView_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedView(films: [])
    }
}
