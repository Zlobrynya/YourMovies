//
//  MainScreenView.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import SwiftUI

struct MainScreenView: View {

    // MARK: - Body

    var body: some View {
        VStack {
            CarouselView()
            Spacer()
        }
    }

    // MARK: - Views

   
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
