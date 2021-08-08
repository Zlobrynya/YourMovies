//
//  BaseRow.swift
//  BaseRow
//
//  Created by Nikita Nikitin on 08.08.2021.
//

import SwiftUI

struct BaseRow<C, T>: View where C: View, T: View {

    // MARK: - Public properties

    var title: LocalizedStringKey
    @ViewBuilder var content: () -> C
    @ViewBuilder var titleView: (Text) -> T

    // MARK: - Lifecycle

    init(
        title: LocalizedStringKey,
        titleView: @escaping (Text) -> T,
        content: @escaping () -> C
    ) {
        self.title = title
        self.titleView = titleView
        self.content = content
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            titleView(Text(title))
            content()
        }
    }
}

struct BaseRow_Previews: PreviewProvider {
    static var previews: some View {
        BaseRow(
            title: "title",
            titleView: { $0 },
            content: { Text("TEST") }
        )
    }
}
