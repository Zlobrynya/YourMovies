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
        VStack {
            carousel
            Spacer()
        }.task {
            await viewModel.featchData()
        }
    }

    // MARK: - Views

    var carousel: AnyView? {
        guard let films = viewModel.topRateMovies else { return nil }
        return AnyView(
            CarouselView(array: films) { item in
                TrendingRowView(film: item)
            }
            .frame(height: 300)
        )
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
