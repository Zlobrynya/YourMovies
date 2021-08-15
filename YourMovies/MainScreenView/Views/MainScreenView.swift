//
//  MainScreenView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import SwiftUI

struct MainScreenView: View {

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
                test
            }
            .background(Color.backgoundSecond)
            .task { await viewModel.featchData() }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Views

    var test: some View {
        VStack {
            topRates
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background { Rectangle().fill(Color.white) }
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }

    // MARK: - Optional Views

    var carousel: AnyView? {
        guard let films = viewModel.topRateMovies else { return nil }
        return TrendingView(items: films)
            .padding([.top, .horizontal], 12)
            .asAnyView()
    }

    var topRates: AnyView? {
        guard let films = viewModel.topRateMovies else { return nil }
        return TopRatedView(films: films)
            .asAnyView()
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
