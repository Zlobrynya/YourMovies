//
//  BaseRow.swift
//  BaseRow
//
//  Created by Nikita Nikitin on 08.08.2021.
//

import SwiftUI

struct BaseRow<C, T>: View where C: View, T: View {

    // MARK: - External Dependencies

    private var title: String
    private var spacing: CGFloat
    @ViewBuilder private var content: () -> C
    @ViewBuilder private var titleView: (Text) -> T

    // MARK: - Lifecycle

    init(
        title: String,
        spacing: CGFloat = 12,
        titleView: @escaping (Text) -> T,
        content: @escaping () -> C
    ) {
        self.title = title
        self.spacing = spacing
        self.titleView = titleView
        self.content = content
    }
    
    init(
        title: String,
        spacing: CGFloat = 12,
        content: @escaping () -> C
    ) where T == Text {
        self.title = title
        self.spacing = spacing
        self.titleView = { $0 }
        self.content = content
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
