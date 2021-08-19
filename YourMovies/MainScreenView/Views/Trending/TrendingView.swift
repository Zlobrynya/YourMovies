//
//  TrendingView.swift
//  TrendingView
//
//  Created by Nikita Nikitin on 07.08.2021.
//

import SwiftUI

struct TrendingView: View {

    // MARK: - External Dependencies

    @EnvironmentObject private var stylingProvider: StylingProvider
    @EnvironmentObject private var stringProvider: LocalizableStringProvider

    var items: [FilmProtocol]

    // MARK: - Body

    var body: some View {
        BaseRow(
            title: stringProvider.dailyTrendingMovies,
            titleView: { $0.foregroundColor(.white) },
            content: {
                CarouselView(array: items) { item in
                    TrendingRowView(film: item)
                }
                .frame(height: stylingProvider.heightRow)
                .padding(.horizontal, 30)
            }
        )
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingView(items: [Film(id: 1, title: "title", posterPath: "", backdropPath: "")])
    }
}
