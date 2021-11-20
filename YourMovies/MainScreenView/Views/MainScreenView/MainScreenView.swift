//
//  MainScreenView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import SwiftUI

struct MainScreenView: View {

    // MARK: - External Dependencies

    @EnvironmentObject private var stylingProvider: StylingProvider
    @EnvironmentObject private var stringProvider: LocalizableStringProvider
    @ObservedObject var viewModel: MainScreenViewModel

    // MARK: - Lifecycle

    init(viewModel: MainScreenViewModel = MainScreenViewModel()) {
        self.viewModel = viewModel
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                carousel
                main
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.backgroundSecond)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
            .task { await viewModel.fetchData() }
        }
    }

    // MARK: - Views

    var main: some View {
        ScrollView {
            VStack {
                topRates
                Spacer()
            }
        }
        .background { Rectangle().fill(Color.white) }
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }

    // MARK: - Optional Views

    var carousel: AnyView? {
        guard let films = viewModel.trendingRateMovies else { return nil }
        return TrendingView(items: films)
            .padding([.top, .horizontal], stylingProvider.spacing12)
            .asAnyView()
    }

    @ViewBuilder
    var topRates: some View {
        if let films = viewModel.topRateMovies {
            MainBaseRowView(
                films: films,
                title: stringProvider.topRatedMovies
            )
        }
//        MainBaseRowView(
//            films: viewModel.topRateMovies ?? preview(),
//            title: stringProvider.topRatedMovies
//        )
//            .redacted(reason: viewModel.topRateMovies == nil ? .placeholder : .privacy)
//            .redacted(reason: .placeholder)
    }

    func preview() -> [FilmProtocol] {
        [Int](0 ... 10).reduce(into: [FilmProtocol]()) { array, id in
            array.append(Film(id: id, title: ""))
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
