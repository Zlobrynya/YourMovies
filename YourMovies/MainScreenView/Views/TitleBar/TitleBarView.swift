//
//  TitleBarView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 21.11.2021.
//

import SwiftUI

struct TitleBarView: View {

    let titles: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(titles, id: \.self) {
                    title($0)
                }
            }
        }
    }

    // MARK: - Views

    @ViewBuilder
    private func title(_ title: String) -> some View {
        Text(title)
    }
}

struct TitleBarView_Previews: PreviewProvider {

    static let titles = ["Movies", "LooongMovies", "Move"]

    static var previews: some View {
        TitleBarView(titles: titles)
    }
}
