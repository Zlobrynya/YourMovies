//
//  MainBaseRowView.swift
//  MainBaseRowView
//
//  Created by Nikita Nikitin on 15.08.2021.
//

import SwiftUI

struct MainBaseRowView: View {

    // MARK: - External Dependencies

    @EnvironmentObject private var stylingProvider: StylingProvider
    var films: [FilmProtocol]
    var title: String

    // MARK: - Body

    var body: some View {
        BaseRow(
            title: title,
            spacing: 8,
            titleView: { $0.padding([.horizontal], stylingProvider.spacing12) },
            content: { filmsView }
        )
    }

    // MARK: - Private properties

    private var filmsView: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(films, id: \.id) { film in
                        image(forUrl: film.posterPath)
                            .frame(width: proxy.size.width / 3, height: proxy.size.height)
                    }
                }.padding([.horizontal], stylingProvider.spacing12)
            }
        }.frame(height: stylingProvider.heightRow)
    }
    
    // MARK: - Private functions

    private func image(forUrl url: String?) -> some View {
        ImageView(
            url: url,
            content: { $0.itemSize() },
            placeholder: { ProgressView() }
        )
    }
}

struct TopReatedView_Previews: PreviewProvider {
    static var previews: some View {
        MainBaseRowView(films: [], title: "")
    }
}
