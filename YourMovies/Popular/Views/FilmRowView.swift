//
//  FilmRowView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 03.07.2021.
//

import SwiftUI

struct FilmRowView: View {
    
    let text: String
    
    var body: some View {
        VStack {
            Image("testImage", bundle: .main)
                .resizable()
                .aspectRatio(contentMode: .fill)
            Text(text)
        }
    }
}

struct FilmRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmRowView(text: "FilmRowView")
    }
}
