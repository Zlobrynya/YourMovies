//
//  PopularView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 26.06.2021.
//

import SwiftUI

struct PopularView: View {
    let data = (1...100).map { "Item \($0)" }
    
    @ObservedObject var viewModel: PopularViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(viewModel.popularFilms.enumerated()), id: \.element) { item in
                    FilmRowView(film: item.element)
                }
            }
            .padding(16)
        }.task {
            await viewModel.fetchFilms()
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView(viewModel: PopularViewModel())
    }
}
