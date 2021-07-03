//
//  PopularView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 26.06.2021.
//

import SwiftUI

struct PopularView: View {
    let data = (1...100).map { "Item \($0)" }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    FilmRowView(text: item)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        PopularView()
    }
}
