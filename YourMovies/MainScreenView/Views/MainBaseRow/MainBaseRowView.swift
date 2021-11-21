//
//  MainBaseRowView.swift
//  MainBaseRowView
//
//  Created by Nikita Nikitin on 15.08.2021.
//

import SwiftUI

struct MainBaseRowView: View {

    // MARK: - Private Properties

    var columns: [GridItem] { [
        GridItem(.fixed(UIScreen.main.bounds.width / 3.6)),
        GridItem(.fixed(UIScreen.main.bounds.width / 3.6)),
        GridItem(.fixed(UIScreen.main.bounds.width / 3.6)),
    ] }

    // MARK: - External Dependencies

    @EnvironmentObject private var stylingProvider: StylingProvider
    var films: [FilmProtocol]
    var title: String

    // MARK: - Body

    var body: some View {
        filmsView
    }

    // MARK: - Private properties

    private var filmsView: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(films, id: \.id) { film in
                image(forUrl: film.posterPath)
            }
        }
        .drawingGroup()
    }

    // MARK: - Private functions

    private func image(forUrl url: String?) -> some View {
        ImageView(
            url: url,
            content: { $0.itemSize() },
            placeholder: { Image("testImage", bundle: .main).itemSize().redacted(reason: .placeholder) }
        )
    }
}

struct TopReatedView_Previews: PreviewProvider {
    static var previews: some View {
        MainBaseRowView(films: [], title: "")
    }
}
