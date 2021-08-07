//
//  TrendingView.swift
//  TrendingView
//
//  Created by Nikita Nikitin on 07.08.2021.
//

import SwiftUI

struct TrendingView: View {

    // MARK: - Public functions

    var items: [Film]

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily trending movies").foregroundColor(.white)
            CarouselView(array: items) { item in
                TrendingRowView(film: item)
            }
        }
        .frame(height: 200)
        .padding([.top, .horizontal], 12)
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingView(items: [.init(id: 1, title: "title", posterPath: "", backdropPath: "")])
    }
}
