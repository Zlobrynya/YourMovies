//
//  TitleBarView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 21.11.2021.
//

import SwiftUI

enum TitleBarItem {
    case topRate
    case upcoming
    case popular

    func title(_ stringProvider: LocalizableStringProviderProtocol) -> String {
        switch self {
        case .topRate: return stringProvider.topRatedMovies
        case .upcoming: return stringProvider.upcomingMovies
        case .popular: return stringProvider.popularMovies
        }
    }
}

struct TitleBarView: View {

    @EnvironmentObject private var stringProvider: LocalizableStringProvider

    let titles: [TitleBarItem]
    let action: (TitleBarItem) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(titles, id: \.self) { titleBarItem in
                    Button(
                        action: { action(titleBarItem) },
                        label: { titleView(titleBarItem.title(stringProvider)) }
                    )
                }
            }
        }
    }

    // MARK: - Views

    @ViewBuilder
    private func titleView(_ title: String) -> some View {
        Text(title)
            .padding(3)
            .background(RoundedCorner(radius: 8).fill(Color.indigo))
            .foregroundColor(.white)
    }
}

struct TitleBarView_Previews: PreviewProvider {

    static let titles: [TitleBarItem] = [.popular, .topRate, .upcoming]

    static var previews: some View {
        TitleBarView(titles: titles, action: { _ in })
    }
}
